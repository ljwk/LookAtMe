package org.dev.lam.CCTV;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketException;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class CCTVService {

	DataInputStream input;
	List<String> userList;
	List<DataOutputStream> temp;
	ServerSocket serverSocket;
	Socket socket;

	BufferedReader bufreader;
	
	public void on() {
		if (serverSocket == null) {
			userList = new ArrayList<>();
			try {
				serverSocket = new ServerSocket(8088);
				startServer();
				MonitorBroadCast();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	private void startServer() {
		new Thread(new Runnable() {
			@Override
			public void run() {
				System.out.println("startServer");
				temp = new ArrayList<>();
				try {
//					 serverSocket.setSoTimeout(1000);
					do {
						do {
							try {
								System.out.println("´ë±â");
								socket = serverSocket.accept();
							} catch (final SocketTimeoutException e) {
								// TimeOut catch
							}
						} while (socket == null);
						System.out.println(socket);
						System.out.println("Access : " + socket.getInetAddress().getHostAddress());
						// userList.add(arg0);
						// System.out.println("userList Add : " + "");
						temp.add(new DataOutputStream(socket.getOutputStream()));
						socket = null;
						System.out.println(socket);
					} while (!temp.isEmpty());
				} catch (SocketException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					try {
						serverSocket.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
					System.out.println("ServerSocket Close");
					serverSocket = null;
				}
			}
		}).start();
	}

	private boolean MonitorBroadCast() {
		if (!serverSocket.isClosed()) {
			URL url;
			try {
				System.out.println("monitor");
				url = new URL("http://192.168.0.25:8083/");
				URLConnection getconn = url.openConnection();
				input = new DataInputStream(getconn.getInputStream());

				bufreader = new BufferedReader(new InputStreamReader(getconn.getInputStream()));
//				ByteArrayOutputStream array = new ByteArrayOutputStream();
//				BufferedInputStream bufinput = new BufferedInputStream(input);
//
//				int len = 0;
//				byte[] by = new byte[512];
//				while ((len = bufinput.read(by)) >= 0) {
//					
//					System.out.println(new String(by));
//					System.out.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
//				}
//				System.out.println("readbyte : " + array.toString());
				if (input != null) {
					System.out.println("CCTV Access");
				}
			} catch (MalformedURLException e) {
				e.printStackTrace();
				System.out.println("CCTV Access fail");
			} catch (IOException e) {
				e.printStackTrace();
				System.out.println("CCTV Access fail");
			}
		}

		sendThread();
		return true;
	}

	private void sendThread() {
		new Thread(new Runnable() {
			@Override
			public void run() {
				try {
					// while (true) {
					for (int i = 0; i < 100;) {
						int size = input.available();
						
						if (size != 0) {
							i++;
							System.out.println(new String(bufreader.readLine()));
							System.out.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
//							FileOutputStream fileout = new FileOutputStream("c:/test/" + i + ".jpg");
//							fileout.write(by);
//							fileout.flush();
//							fileout.close();
						}
//						for (DataOutputStream e : temp) {
//							e.write(by);
//							e.flush();
//						}
					}
				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					try {
						if (socket != null) {
							socket.close();
							socket = null;
						}

						if (input != null) {
							input.close();
							input = null;
						}

						userList.clear();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}).start();
	}
}
