resource "aws_key_pair" "key" {
  key_name   = "${var.name}-key"
  public_key = "${var.public_key}"
}
resource "aws_instance" "ec2-instance" {
  availability_zone           = "${var.availability_zone}"
  key_name                    = "${aws_key_pair.key.key_name}"
  instance_type               = "${var.instance_type}"
  ami                         = "${var.ami}"
  subnet_id                   = "${var.subnet_id}"
  vpc_security_group_ids      = ["${var.sg_id}"]
  associate_public_ip_address = "true"
  root_block_device {
    volume_size               = "${var.root_volume_size}"
    volume_type               = "${var.root_volume_type}"
   }
  iam_instance_profile        = "${var.ec2_profile}"
    tags {
      Name                    = "${var.name}_server"
    }
  user_data = <<EOF
<powershell>
net user ${var.instance_username} '${var.admin_password}' /add /y
net localgroup administrators ${var.instance_username} /add

winrm quickconfig -q
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB=”300″}'
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name="WinRM 5986" protocol=TCP dir=in localport=5986 action=allow

net stop winrm
sc.exe config winrm start=auto
net start winrm
</powershell>
EOF

  provisioner "file" {
  source = "test.txt"
  destination = "C:/test.txt"
    connection {
      type = "winrm"
      timeout = "10m"
      user = "${var.instance_username}"
      password = "${var.admin_password}"
    }
  }
}

output "aws_instance_id" {
  value = "${aws_instance.ec2-instance.id}"
}
