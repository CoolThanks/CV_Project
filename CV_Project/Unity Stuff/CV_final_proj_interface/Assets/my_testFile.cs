using UnityEngine;
using System.Collections;
using System.Net.Sockets;
using System.Net;
using System.IO;
using System.Text;
using System;



public class my_testFile : MonoBehaviour {

	public Stream stream;
	Byte[] data = new Byte[256];
	Int32 bytes = 0;
	String responseData = String.Empty;
	String[] mystring;
	Byte[] checkstring = new Byte[256];
	Boolean changed;
	// Use this for initialization
	void Start () {
		stream = Connect ("127.0.0.1", "begin", data);
		checkstring = System.Text.Encoding.ASCII.GetBytes("good\r\n");
	}
	
	// Update is called once per frame
	void Update () {
		
		if (stream == null) {
			return;
		}
		
		
		bytes = stream.Read (data, 0, data.Length);
		if (responseData != System.Text.Encoding.ASCII.GetString (data, 0, bytes)) {
			changed = true;
		}
		responseData = System.Text.Encoding.ASCII.GetString (data, 0, bytes);
		Debug.Log(responseData.ToString());

	}
	
	static Stream Connect(String server, String message, Byte[] data) 
	{
		
		try {

			Int32 port = 10000;
			TcpClient client = new TcpClient (server, port);
			
			// Translate the passed message into ASCII and store it as a Byte array.
			data = System.Text.Encoding.ASCII.GetBytes (message);         
			
			// Get a client stream for reading and writing.
			Stream stream = client.GetStream();
			
			//NetworkStream stream = client.GetStream ();
			
			// Send the message to the connected TcpServer. 
			stream.Write (data, 0, data.Length);
			//Console.WriteLine("Sent: {0}", message);         
			
			// Receive the TcpServer.response.
			
			// Buffer to store the response bytes.
			data = new Byte[256];
			
			// String to store the response ASCII representation.
			//String responseData = String.Empty;
			
			// Read the first batch of the TcpServer response bytes.
			//Int32 bytes = stream.Read (data, 0, data.Length);
			//Debug.Log (System.Text.Encoding.ASCII.GetString (data));
			
			return stream;
			//responseData = System.Text.Encoding.ASCII.GetString (data, 0, bytes);
			//Debug.Log(responseData.ToString());
		} catch (ArgumentNullException e) {
			//Console.WriteLine("ArgumentNullException: {0}", e);
			Debug.Log (e);
			Debug.Log ("here1");
			Application.Quit();
			return null;
		} catch (SocketException e) {
			//Console.WriteLine("SocketException: {0}", e);
			Debug.Log (e);
			//Debug.Log ("here2");
			//Application.Quit();
			return null;
		}
		
		//Console.WriteLine("\n Press Enter to continue...");
		//Console.Read();
	}
	
}

