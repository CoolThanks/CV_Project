using UnityEngine;
using System.Collections;
using System.Net.Sockets;
using System.Net;
using System.IO;
using System.Text;
using System;
using UnityEngine.UI;

public class TCP_Connection : MonoBehaviour
{

	public Text countText;
	public Image current;
	public Image next;
	public Image future;
	public Sprite[] y;
	public Sprite[] m;
	public Sprite[] c;
	public Sprite[] a;
	int yCounter = 0;
	int mCounter = 0;
	int cCounter = 0;
	int aCounter = 0;
	int move = 1;
	//1==y 2==m 3==c 4==d
	private int count;
	public Stream stream;
	byte[] data = new byte[256];
	int bytes = 0;
	string responseData = string.Empty;
	string[] mystring;
	byte[] checkstring = new byte[256];
	bool changed;

	void Start ()
	{
		count = 0;
		SetCountText ();
		InvokeRepeating ("Images", 0.0f, 0.1f);
		stream = Connect ("127.0.0.1", "begin", data);
		stream.ReadTimeout = 10;
		checkstring = System.Text.Encoding.ASCII.GetBytes ("good\r\n");
	}

	void Images ()
	{
		if (move == 1) {
			current.GetComponent<Image> ().sprite = y [yCounter];
			next.GetComponent<Image> ().sprite = m [mCounter];
			future.GetComponent<Image> ().sprite = c [cCounter];
		} else if (move == 2) {
			current.GetComponent<Image> ().sprite = m [mCounter];
			next.GetComponent<Image> ().sprite = c [cCounter];
			future.GetComponent<Image> ().sprite = a [aCounter];
		} else if (move == 3) {
			current.GetComponent<Image> ().sprite = c [cCounter];
			next.GetComponent<Image> ().sprite = a [aCounter];
			future.GetComponent<Image> ().sprite = y [yCounter];
		} else if (move == 4) {
			current.GetComponent<Image> ().sprite = a [aCounter];
			next.GetComponent<Image> ().sprite = y [yCounter];
			future.GetComponent<Image> ().sprite = m [mCounter];
		}
		yCounter++;
		mCounter++;
		cCounter++;
		aCounter++;
		if (yCounter > 17) {
			yCounter = 0;
		}
		if (mCounter > 14) {
			mCounter = 0;
		}
		if (cCounter > 15) {
			cCounter = 0;
		}
		if (aCounter > 15) {
			aCounter = 0;
		}
	}

	void Update ()
	{
		if (stream == null) {
			return;
		}
		try {
			bytes = stream.Read (data, 0, data.Length);
			if (responseData != System.Text.Encoding.ASCII.GetString (data, 0, bytes)) {
				changed = true;
			}
			responseData = System.Text.Encoding.ASCII.GetString (data, 0, bytes);
		} catch (Exception e) {
			responseData = "";
		}
		if (responseData.Length > 0) {
			//Debug.Log (responseData.ToString ());
			if (responseData.ToString ().Equals ("Good")) {
				count = count + 50;
			}
			move++;
			yCounter = 0;
			mCounter = 0;
			cCounter = 0;
			aCounter = 0;
			if (move > 4) {
				move = 1;
			}
		}
		stream.Flush ();
	}

	void SetCountText ()
	{
		countText.text = "Score: " + count.ToString ();
	}

	static Stream Connect (String server, String message, Byte[] data)
	{

		try {
			Int32 port = 10000;
			TcpClient client = new TcpClient (server, port);

			// Translate the passed message into ASCII and store it as a Byte array.
			data = System.Text.Encoding.ASCII.GetBytes (message);         
			Stream stream = client.GetStream ();
			stream.Write (data, 0, data.Length);
			data = new Byte[256];
			Debug.Log (System.Text.Encoding.ASCII.GetString (data));
			return stream;

		} catch (ArgumentNullException e) {
			Debug.Log (e);
			Application.Quit ();
			return null;
		} catch (SocketException e) {
			Debug.Log (e);
			return null;
		}
	}
}
