#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start
sudo echo "Welcome to Indrajeet's Portfolio 2" | sudo tee /var/www/html/index.html
sudo mkdir /var/www/html/web
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(15, 232, 192);"> <h1>Welcome to indrajeet - webserver 2</h1> <p>Terraform Demo</p> <p>Application Version: V2</p> </body></html>' | sudo tee /var/www/html/web/index.html

