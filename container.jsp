<!DOCTYPE html>
<html lang="en" >

<head>
  <meta charset="UTF-8">
  <title>Thunderbird Email Client</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">

  
      <style>
      /* NOTE: The styles were added inline because Prefixfree needs access to your styles and they must be inlined if they are on local disk! */
      @import url("https://fonts.googleapis.com/css?family=Raleway:400,700");
*, *:before, *:after {
  box-sizing: border-box;
}

body {
  min-height: 100vh;
  font-family: 'Raleway', sans-serif;
}

.container {
  position: absolute;
  width: 100%;
  height: 100%;
  overflow: hidden;
}
.container:hover .top:before, .container:hover .top:after, .container:hover .bottom:before, .container:hover .bottom:after, .container:active .top:before, .container:active .top:after, .container:active .bottom:before, .container:active .bottom:after {
  margin-left: 200px;
  transform-origin: -200px 50%;
  transition-delay: 0s;
}
.container:hover .center, .container:active .center {
  opacity: 1;
  transition-delay: 0.2s;
}

.top:before, .top:after, .bottom:before, .bottom:after {
  content: '';
  display: block;
  position: absolute;
  width: 200vmax;
  height: 200vmax;
  top: 50%;
  left: 50%;
  margin-top: -100vmax;
  transform-origin: 0 50%;
  transition: all 0.5s cubic-bezier(0.445, 0.05, 0, 1);
  z-index: 10;
  opacity: 0.65;
  transition-delay: 0.2s;
}

.top:before {
  transform: rotate(45deg);
  background: #454757;
}
.top:after {
  transform: rotate(135deg);
  background: #5267a3;
}

.bottom:before {
  transform: rotate(-45deg);
  background: #6c6d79;
}
.bottom:after { 
  transform: rotate(-135deg);
  background: #3745b5;
}
.center {
  position: absolute;
  width: 400px;
  height: 400px;
  top: 50%;
  left: 50%;
  margin-left: -200px;
  margin-top: -200px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 30px;
  opacity: 0;
  transition: all 0.5s cubic-bezier(0.445, 0.05, 0, 1);
  transition-delay: 0s;
  color: #333;
}
.center input {
  width: 100%;
  padding: 15px;
  margin: 5px;
  border-radius: 1px;
  border: 1px solid #ccc;
  font-family: inherit;
}

    </style>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/prefixfree/1.0.7/prefixfree.min.js"></script>

</head>

<body>

  
<div class="container" >
  <div class="top"></div>
  <div class="bottom"></div>
  <div class="center">
    <h4>
    
<%@ page language="java" import="java.io.*,java.util.*,java.sql.*"%>
<%
String service = (String)session.getAttribute("service");
String email = (String)session.getAttribute("email");
String uname = (String)session.getAttribute("uname");
String port = (String)session.getAttribute("port");
String name = uname+"_"+service; 
session.setAttribute("name",name);
String image = (String)session.getAttribute("image");
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","");
Statement st = con.createStatement(); 
ResultSet res = st.executeQuery("select port from containers where email = '"+email+"' and name= '"+name+"';");
if(res.next())
{
	int p = res.getInt("port");
	String access2="http://192.168.21.140:"+p;
	out.println("Service already exists!<br>");
	%><a href="<%out.print(access2);%> "target='_blank'>Click to access the service</a><%
	return;
}
res.previous();
InputStream is = null;
        ByteArrayOutputStream baos = null;
		ProcessBuilder pb = new ProcessBuilder("docker", "run", "-dit", "-p",port+":10000","--name", name, image);
        try {
            Process prs = pb.start();
            is = prs.getInputStream();
            byte[] b = new byte[1024];
            int size = 0;
            baos = new ByteArrayOutputStream();
            while((size = is.read(b)) != -1){
                baos.write(b, 0, size);
            }
            System.out.println(new String(baos.toByteArray()));
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally{
            try {
                if(is != null) is.close();
                if(baos != null) baos.close();
            } catch (Exception ex){}
        }
        
        String access = "http://192.168.21.140:"+port;
		out.println("Successfully configured the application!<br>Lanuching the application...<br>Application launched successfully.<br>");
		%><a href="<%out.print(access);%> "target='_blank'>Click to access the service</a><%
		RequestDispatcher rs = request.getRequestDispatcher("db.jsp");
		rs.include(request,response);
%>
    
    </h4>
    <h2>&nbsp;</h2>
    <p>  <a href="success.jsp" >Home</a>
    </p>
  </div>
</div>
  <script src='https://codepen.io/tonybanik/pen/3f837b2f0085b5125112fc455941ea94.js'></script>

  

</body>

</html>
