resource "aws_instance" "ec2-instance" {
  availability_zone           = "${var.availability_zone}"
  key_name                    = "${var.key_name}"
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

$url = "https://raw.githubusercontent.com/jborean93/ansible-windows/master/scripts/Install-WMF3Hotfix.ps1"
$file = "$env:temp\Install-WMF3Hotfix.ps1"
(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)
powershell.exe -ExecutionPolicy ByPass -File $file -Verbose

$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"
(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)
powershell.exe -ExecutionPolicy ByPass -File $file

winrm quickconfig -q
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="300"}'
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name="RDP" protocol=TCP dir=in localport=3389 action=allow
netsh advfirewall set allprofiles state off

net stop winrm
sc.exe config winrm start=auto
net start winrm

</powershell>
EOF
}

output "aws_instance_id" {
  value = "${aws_instance.ec2-instance.id}"
}
