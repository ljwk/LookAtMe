package org.dev.lam.CCTV;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.ConnectException;
import java.net.MalformedURLException;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketException;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.dev.lam.Security.CustomAuthenticationProvider;
import org.dev.lam.Security.SecurityDAO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CCTVService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	DataInputStream input;
	List<String> userList;
	List<DataOutputStream> temp;
	ServerSocket serverSocket;
	Socket socket;
	String header;

	BufferedReader bufreader;

	public void on() {
		System.out.println(serverSocket);
		if (serverSocket == null) {
			System.out.println("Create ServerSocket");
			userList = new ArrayList<>();
			try {
				serverSocket = new ServerSocket(8088);
				if (MonitorBroadCast()) {
					startServer();
				}
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
					 serverSocket.setSoTimeout(1000);
					do {
						do {
							try {
								System.out.println("대기");
								socket = serverSocket.accept();
							} catch (final SocketTimeoutException e) {
								// TimeOut catch
							} finally {
//								if (userList.isEmpty()) {
								if (temp.isEmpty()) {
									return;
								}
							}
						} while (socket == null);
						System.out.println("Access : " + socket.getInetAddress().getHostAddress());
						// userList.add(arg0);
						// System.out.println("userList Add : " + "");
						DataOutputStream output = new DataOutputStream(socket.getOutputStream());
						output.writeBytes(header);
						output.flush();
						// System.out.println(header);
						System.out.println("헤더전송");

						temp.add(output);
						socket = null;
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
			int retry = 1;
			try {
				System.out.println("monitor");
				url = new URL("http://192.168.2.26:8083/");
				URLConnection getconn = url.openConnection();
				
				do {
					try {
						input = new DataInputStream(getconn.getInputStream());
					} catch(ConnectException e) {
						System.out.println("Connection fail");
						System.out.println("retry : " + retry++);
						try {
							Thread.sleep(1000);
						} catch (InterruptedException e1) {
							e1.printStackTrace();
						}
					} finally {
						if (retry == 4) {
							System.out.println("Connection fail");
							serverSocket.close();
							serverSocket = null;
							return false;
						}
					}
				} while (input == null);

				header = new String();
				Map<String, List<String>> map = getconn.getHeaderFields();
				System.out.println(map.keySet());
				for (String keye : map.keySet()) {
					List<String> list = map.get(keye);
					for (String vale : list) {
						if (keye == null) {
							vale += "\r\n";
							vale += header;
							header = vale;
						} else {
							header += keye + ": ";
							header += vale + "\r\n";
						}
						// System.out.println(keye);
						// System.out.println(vale);
					}
					// System.out.println("---------------------");
				}

				String BOUNDARY = "--gc0p4Jq0M2Yt08jU534c0p--";
				String BOUNDARY_LINES = "\r\n" + BOUNDARY + "\r\n";

				header += BOUNDARY_LINES;

				bufreader = new BufferedReader(new InputStreamReader(getconn.getInputStream()));
				// ByteArrayOutputStream array = new ByteArrayOutputStream();
				// BufferedInputStream bufinput = new
				// BufferedInputStream(input);
				//
				// int len = 0;
				// byte[] by = new byte[512];
				// while ((len = bufinput.read(by)) >= 0) {
				//
				// System.out.println(new String(by));
				// System.out.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
				// }
				// System.out.println("readbyte : " + array.toString());
				if (input != null) {
					System.out.println("CCTV Access");
				}
			} catch (MalformedURLException e) {
				e.printStackTrace();
				System.out.println("CCTV Access fail");
				return false;
			} catch (IOException e) {
				e.printStackTrace();
				System.out.println("CCTV Access fail");
				return false;
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
					ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
					ByteArrayInputStream byteArrayInputStream;
					String imgheader = "";
					String line = null;
					byte[] imgbyte;
					int length = 0;
					String timestamp;
					bufreader.readLine();
					int a = 1;
					while (true) {
//						do {
//							byteArrayOutputStream.write(input.readByte());
//						}while(!byteArrayOutputStream.toString().contains("Content-type: image/jpeg\r\n"));
//						byteArrayOutputStream.reset();
//						byteArrayOutputStream.write("Content-type: image/jpeg\r\n".getBytes());
//
//						do {
//							byteArrayOutputStream.write(input.readByte());
//						} while (!byteArrayOutputStream.toString().contains("--gc0p4Jq0M2Yt08jU534c0p--"));
//						int hlength = byteArrayOutputStream.size();
//						byte[] hboundary = new byte[byteArrayOutputStream.size()];
//						byteArrayInputStream = new ByteArrayInputStream(byteArrayOutputStream.toByteArray(), 0, hlength -30);
//						hboundary = new byte[byteArrayInputStream.available()];
//						byteArrayInputStream.read(hboundary);
//						imgheader = new String(hboundary);
//						
//						byteArrayOutputStream.reset();
//						System.out.println("header : \n" + imgheader);
//						
//						do {
//							byteArrayOutputStream.write(input.readByte());
//						} while (!byteArrayOutputStream.toString().contains("--gc0p4Jq0M2Yt08jU534c0p--"));
//						
//						length = byteArrayOutputStream.toByteArray().length;
//						
//						byteArrayInputStream = new ByteArrayInputStream(byteArrayOutputStream.toByteArray(), 0, length - 28);
//						imgbyte = new byte[byteArrayInputStream.available()];
//						byteArrayInputStream.read(imgbyte);
//
//						byteArrayOutputStream.reset();
//						System.out.println("bufarr : \n" + new String(imgbyte));
//
//						System.out.println("length : " + length);
//						System.out.println("length : " + imgbyte.length);
//						for (DataOutputStream e : temp) {
//							e.writeBytes(imgheader);
//							e.write(imgbyte);
//							e.writeBytes("\r\n--gc0p4Jq0M2Yt08jU534c0p--\r\n");
//							e.flush();
//						}
						imgheader = "";
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

//						userList.clear();
						temp.clear();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}).start();
	}

	public boolean viewPermit(String sessionid) {
		Map<String, String> online = CustomAuthenticationProvider.getOnline();
		System.out.println(sessionid);
		System.out.println(online.keySet());
		if (online.containsKey(sessionid)) {
			String id = online.get(sessionid);
			System.out.println(id);
			return true;
		} else {
			return false;
		}
	}
}
