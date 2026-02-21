#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start
sudo echo "Welcome to Indrajeet's Portfolio" | sudo tee /var/www/html/index.html
sudo mkdir /var/www/html/webserver
sudo echo "Test has been completed successfully, Thankyou" | sudo tee /var/www/html/webserver/index.html
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Stack Simplify - APP</h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/webserver/index.html
sudo curl http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/webserver/metadata.html

