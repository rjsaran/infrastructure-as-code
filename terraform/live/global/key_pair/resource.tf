# AWS key pair
resource "aws_key_pair" "key_pair" {
    key_name   = "ec2_instance.pem"
    public_key = file("${var.ssh_public_key_file}")
}