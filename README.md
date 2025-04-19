# Development Environment Setup Guide

This guide will help you set up a development environment for web, desktop, and GUI applications with Linux terminal support on a Windows host using VirtualBox, VSCode, XServer (XDisplay), and SSH.

## Important Prerequisites

Before proceeding, ensure Python is installed on your Windows system:

1. If not installed, download and install Python from [https://www.python.org/](https://www.python.org/)
2. Install pywin32 by running the following command in Windows Command Prompt:
   ```
   pip install pywin32
   ```

> **Note:** VirtualBox relies on Python and pywin32. Uninstalling Python from your host machine or removing pywin32 will disrupt the functionality of VirtualBox.

## Windows Host Configuration

### Install OpenSSH Server

**Option 1: Using Settings app**
1. Open the Settings app
2. Go to Apps > Optional features
3. Click "Add a feature"
4. Select OpenSSH Server and OpenSSH Client

**Option 2: Using PowerShell**
```powershell
Get-WindowsCapability -Name OpenSSH.Server.Feature -Online | Enable-WindowsOptionalFeature -Online -NoRestart
```

### Configure OpenSSH Server

1. Open the Services app
2. Find the "OpenSSH SSH Server" service
3. Set the startup type to "Automatic"
4. Start the service

### Configure Windows Firewall

Open PowerShell as Administrator and run:
```powershell
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
```

## Setup and Installation

### Required Software

1. **VirtualBox**: Download from [https://www.virtualbox.org/](https://www.virtualbox.org/)
2. **Linux Mint** (Cinnamon Edition): Download from [https://linuxmint.com/](https://linuxmint.com/)
   - If you prefer a different edition, download as per your preference
   - Ubuntu is also an option: [https://ubuntu.com/](https://ubuntu.com/)
3. **VSCode**: Download from [https://code.visualstudio.com/](https://code.visualstudio.com/)
4. **XServer**: Download from [https://sourceforge.net/projects/vcxsrv/](https://sourceforge.net/projects/vcxsrv/)

### Installation Steps

1. **Install VirtualBox**
   - Proceed with default settings recommended by VirtualBox

2. **Install VSCode**
   - Proceed with default settings recommended by VSCode

3. **Install XServer**
   - Proceed with default settings recommended by vcxsrv

## Configuration Guide

### Setting Up Linux in VirtualBox

1. Open VirtualBox and click on "New"
2. Locate the Linux Mint ISO file and click "Finish"
3. Press the start button after successful boot
4. Select "Linux Mint (Compatibility Mode)" and proceed with installation

### Completing Linux Installation

1. After pressing "Install now", proceed through the installation steps
2. In the final step, set up your username and password
3. Check "Automatic login" to avoid entering password every time (you can change this setting later if required)

### Configuring Linux for Development

After Linux Mint installation is successful, open the terminal and run these commands:

```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install openssh-server openssh-client xclock xeyes
```
