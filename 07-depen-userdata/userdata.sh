sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl status httpd
echo "<h1>Welcome to my AWS EC2 instance</h1>" | sudo tee /var/www/html/index.html