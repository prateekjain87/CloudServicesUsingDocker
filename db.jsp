<%@ page import ="java.sql.*,java.net.UnknownHostException,java.net.InetAddress"%>
<%
String service = (String)session.getAttribute("service");
String service_id = (String)session.getAttribute("service_id");
String email = (String)session.getAttribute("email");
String ipaddr=InetAddress.getLocalHost().getHostAddress();
String port = (String)session.getAttribute("port");
String con_name = (String)session.getAttribute("name");
String[] ipAddressInArray = ipaddr.split("\\.");
int ip;
long result = 0;
for (int i = 0; i < ipAddressInArray.length; i++) {

	int power = 3 - i;
	ip = Integer.parseInt(ipAddressInArray[i]);
	result += ip * Math.pow(256, power);

}
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","");
Statement st = con.createStatement(); 
int i = st.executeUpdate("insert into containers values('" + email +"','" + con_name + "', '" + service + "','" + port + "','" + result + "', CURRENT_TIMESTAMP)");
//if (i!=0) {
//	out.print("\nThe service has been launched!");
//}
%>
