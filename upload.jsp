<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
	"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>File Upload</title>
</head>
<body>

	<video id="video" width="640" height="480" autoplay></video>
	<button id="snap">Snap Photo</button>
	<button id="save">Save Photo</button>
	<canvas id="canvas" width="640" height="480"></canvas>

	<form method="post" action="save.jsp">
		<input type="hidden" name="file" id="file" /> <input type="submit"
			id="upload" value="upload" />
	</form>
	<script type="text/javascript">
		// Grab elements, create settings, etc.
		var video = document.getElementById('video');

		// Get access to the camera!
		if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
			// Not adding `{ audio: true }` since we only want video now
			navigator.mediaDevices.getUserMedia({
				video : true
			}).then(function(stream) {
				//video.src = window.URL.createObjectURL(stream);
				video.srcObject = stream;
				video.play();
			});
		}

		/* Legacy code below: getUserMedia 
		 else if(navigator.getUserMedia) { // Standard
		 navigator.getUserMedia({ video: true }, function(stream) {
		 video.src = stream;
		 video.play();
		 }, errBack);
		 } else if(navigator.webkitGetUserMedia) { // WebKit-prefixed
		 navigator.webkitGetUserMedia({ video: true }, function(stream){
		 video.src = window.webkitURL.createObjectURL(stream);
		 video.play();
		 }, errBack);
		 } else if(navigator.mozGetUserMedia) { // Mozilla-prefixed
		 navigator.mozGetUserMedia({ video: true }, function(stream){
		 video.srcObject = stream;
		 video.play();
		 }, errBack);
		 }
		 */

		// Elements for taking the snapshot
		var canvas = document.getElementById('canvas');
		var context = canvas.getContext('2d');
		var video = document.getElementById('video');

		// Trigger photo take
		document.getElementById("snap").addEventListener("click", function() {
			context.drawImage(video, 0, 0, 640, 480);
		});

		function saveAsLocalImage() {
			var myCanvas = document.getElementById("canvas");
			// here is the most important part because if you dont replace you will get a DOM 18 exception.  
			// var image = myCanvas.toDataURL("image/png").replace("image/png", "image/octet-stream;Content-Disposition: attachment;filename=foobar.png");  
			var image = myCanvas.toDataURL("image/png").replace("image/png","image/octet-stream");
			// window.location.href = image; // it will save locally  
			// create temporary link  
			var tmpLink = document.createElement('a');
			tmpLink.download = 'image.png'; // set the name of the download file 
			tmpLink.href = image;

			// temporarily add link to body and initiate the download  
			document.body.appendChild(tmpLink);
			tmpLink.click();
			document.body.removeChild(tmpLink);
		}
		function upload() {
			var myCanvas = document.getElementById("canvas");
			// here is the most important part because if you dont replace you will get a DOM 18 exception.  
			// var image = myCanvas.toDataURL("image/png").replace("image/png", "image/octet-stream;Content-Disposition: attachment;filename=foobar.png");  
			var image = myCanvas.toDataURL("image/png");
			// window.location.href = image; // it will save locally  
			
			document.getElementById('file').value = image;
			
		}

		// Trigger photo save
		document.getElementById("save").addEventListener("click", function() {
			saveAsLocalImage();
		});
		// Trigger photo upload
		document.getElementById("upload").addEventListener("click",function() {
			upload();
		});
	</script>

</body>
</html>