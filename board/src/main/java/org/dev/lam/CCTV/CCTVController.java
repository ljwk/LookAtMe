package org.dev.lam.CCTV;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.URLConnection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/cctv")
public class CCTVController {
	
	@Autowired
	private CCTVService service;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String cctv(Model model) {
		return "cctv/cctv";
	}
	
	@RequestMapping(value = "/view")
	public String view(Model model){
		service.on();
		System.out.println("on");
		return "cctv/view";
	}
	
	@RequestMapping(value = "/test")
	public void image() {
		DataInputStream input = null;
		Socket socket = null;
		ServerSocket serverSocket = null;
		
		try {
			serverSocket = new ServerSocket(8088);
			serverSocket.setSoTimeout(1000 /* milliseconds */);
			while (true) {
				do {
					try {
						System.out.println("¥Î±‚");
						socket = serverSocket.accept();
					} catch (final SocketTimeoutException e) {
						System.out.println("è≥");
					}
				} while (socket == null);

				System.out.println(socket);

				URL url = new URL("http://192.168.0.25:8083/");
				URLConnection getconn = url.openConnection();
				input = new DataInputStream(getconn.getInputStream());

				imageThread(socket, input);
				socket = null;
				// serverSocket.close();
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private void imageThread(Socket socket, DataInputStream input) {
		new Thread(new Runnable() {
			@Override
			public void run() {
				try {
					DataOutputStream output = null;
					output = new DataOutputStream(socket.getOutputStream());
					
					while (true) {
						byte by= input.readByte();
						System.out.println(input.readByte());
						output.write(by);
						output.flush();
					}
				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					try {
						socket.close();
						input.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}).start();
	}
	
}
