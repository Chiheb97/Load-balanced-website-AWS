#!/bin/bash

IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

amazon-linux-extras install nginx1 -y
systemctl start nginx
systemctl enable nginx

echo "<html>
<head>
</head>
<body>
<h1>$IP</h1>
</body>
</html>" > "/usr/share/nginx/html/index.html