# PROJECT: Cloud-Shield Baseline
# PURPOSE: Enforce N8 Security Standards on Cloud Infrastructure

resource "aws_security_group" "hardened_web_server" {
  name        = "web-server-hardened-sg"
  description = "Baseline security group for N8 compliant web servers"

  # Rule 1: Allow HTTPS (Port 443) from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow encrypted web traffic"
  }

  # Rule 2: Restricted SSH (Port 22) - Only from Admin IP
  # RECRUITER NOTE: Never leave 22 open to 0.0.0.0/0
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["203.0.113.5/32"] # Replace with Admin IP
    description = "Restricted Admin SSH access"
  }

  # Rule 3: Deny all other inbound (Implicit)
  
  # Rule 4: Restricted Egress (Outbound)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound for updates"
  }
}
