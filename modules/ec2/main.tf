resource "aws_instance" "server2016" {
  connection {
    type     = "winrm"
    user     = "Administrator"
    password = "${var.admin_password}"
    # set from default of 5m to 10m to avoid winrm timeout
    timeout = "10m"
  }
  availability_zone           = "${var.availability_zone}"
  instance_type               = "${var.instance_type}"
  ami                         = "${var.ami}"
  key_name                    = "${var.key_name}"
  subnet_id                   = "${var.subnet_id}"
  vpc_security_group_ids      = ["${var.sg_id}"]
  associate_public_ip_address = "true"
  iam_instance_profile        = "${var.ec2_profile}"
    tags {
      Name                     = "${var.name}_server"
    }
  user_data = <<EOF
    <script>
      winrm quickconfig -q & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
    </script>
    <powershell>
      netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
      # Set Administrator password
      $admin = [adsi]("WinNT://./administrator, user")
      $admin.psbase.invoke("SetPassword", "${var.admin_password}")
    </powershell>
    EOF
}
output "aws_instance_id" {
  value = "${aws_instance.server2016.id}"
}
