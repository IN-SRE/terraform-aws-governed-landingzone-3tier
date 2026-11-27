#!/bin/bash
set -euo pipefail


# ----- app user data -----
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start
sudo echo "Welcome to Indrajeet's Portfolio" | sudo tee /var/www/html/index.html
sudo mkdir /var/www/html/webserver
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to indrajeet - webserver</h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/webserver/index.html


# ----- Vault Agent section (Amazon Linux) -----
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
yum install -y vault

mkdir -p /etc/vault-agent /opt/vault-agent /etc/app

# Agent config: AWS IAM login, token sink, DB credential template
cat > /etc/vault-agent/agent.hcl <<EOC
vault {
  address = "${vault_address}"
}

auto_auth {
  method "aws" {
    mount_path = "auth/aws"
    config = {
      type = "iam"
      role = "${app_role}"
    }
  }

  sink "file" {
    config = {
      path = "/opt/vault-agent/token"
    }
  }
}

template {
  source      = "/etc/vault-agent/db-creds.ctmpl"
  destination = "/etc/app/db-creds.env"
  perms       = "0600"
}
EOC

# Template: renders DB user and password from a dynamic secret
cat > /etc/vault-agent/db-creds.ctmpl <<'EOT'
{{ with secret "database/creds/${db_role}" }}
DB_USER={{ .Data.username }}
DB_PASSWORD={{ .Data.password }}
{{ end }}
EOT

# systemd unit so the agent starts on boot and restarts on failure
cat > /etc/systemd/system/vault-agent.service <<'EOU'
[Unit]
Description=Vault Agent
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/usr/bin/vault agent -config=/etc/vault-agent/agent.hcl
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOU

systemctl daemon-reload
systemctl enable --now vault-agent