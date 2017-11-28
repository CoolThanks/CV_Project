using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class WebCam : MonoBehaviour {
	
	public RawImage rawimage;
	// Use this for initialization
	void Start () {
		WebCamDevice[] devices = WebCamTexture.devices;
		WebCamTexture webcamTexture = new WebCamTexture();
		webcamTexture.deviceName = devices[2].name;
		rawimage.texture = webcamTexture;
		rawimage.material.mainTexture = webcamTexture; 
		webcamTexture.Play();
	}
	
	// Update is called once per frame
	void Update () {
		
	}
}
