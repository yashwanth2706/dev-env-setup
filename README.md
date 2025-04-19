Development Envirornment for Web, Desktop, GUI applications with linux terminal support in Windows Host with VirtualBox, vscode, Xserver (XDisplay) and SSH

IMPORTANT!

Before we proceed:
Make sure python is installed, if not installed install from https://www.python.org/
In Windows CMD type and install pywin32
```pip install pywin32```

This'll make sure that virtual box will install properly and won't face any issues, virtula box relies on python and pywin32
uninstalling python from Host machine or removing pywin32 will distrupt the functionalities of the virtualbox

In Windows

1. Insall openSSH server:
Open the Settings app, go to Apps > Optional featuresClick Add a feature and select OpenSSH Server/ OpenSSH Clinet

Alternatively, 
You can use PowerShell as Administrator to install the OpenSSH Server: Get-WindowsCapability -Name OpenSSH.Server.Feature -Online | Enable-WindowsOptionalFeature -Online -NoRestart

2. Configure OpenSSH Server:
Open the Services app and find the OpenSSH SSH Server service.
Set the startup type to Automatic and start the service. 

3. Configure Windows Firewall:
Open PowerShell as Administrator and run the following command to allow SSH traffic through the firewall: New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22


SETUP and INSTALLATION GUIDE:

SETUP:

Downlaod VirtualBox in windows: https://www.virtualbox.org/
Download LinuxMint (Cinnamon Edition): https://linuxmint.com/

If you prefer using different edition you can download as per your prefference
If you prefer using Ubuntu (Optional) https://ubuntu.com/

Downlaod VScode: https://code.visualstudio.com/

Download Xserver: https://sourceforge.net/projects/vcxsrv/

INSTALLATION:

Install VirtualBox
Proceed with default settings recommended by virtualbox, nothing needs to be changed

Install VScode
Proceed with default settings recommended by VScode, nothing needs to be changed

Install Xserver
Proceed with default settings recommended by vcxsrv, nothing needs to be changed

GUIDE:

Open VirtualBox and click on New, locate LinuxMint ISO file and click finish
Press start button after the succsfull boot, select Linux Mint (Compatability Mode) and proceed to Install in VirtualBox

After pressing Install now, in the last step setup username, password and check automatic login to avoid entering password everytime, you can change this setting anytime if required

After Linux Mint Installation is successful in virtualbox
open terminal and write below command and press enter

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install openssh-server openssh-client xclock xeyes
