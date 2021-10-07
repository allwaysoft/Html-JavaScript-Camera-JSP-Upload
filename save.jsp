
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Base64"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
	"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Upload</title>
</head>
<body>
	<%
	FileOutputStream fos = null;
	try {
		String imageString = request.getParameter("file");
		imageString = imageString.substring("data:image/png;base64,".length());
		byte[] contentData = imageString.getBytes();
		byte[] decodedData = Base64.getDecoder().decode(contentData);
		String imgName = request.getServletContext().getRealPath("uploadFiles") + "\\" + String.valueOf(System.currentTimeMillis()) + ".png";
		out.println(imgName);
		fos = new FileOutputStream(imgName);
		fos.write(decodedData);
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (fos != null) {
			fos.close();
		}
	}
	%>

</body>
</html>