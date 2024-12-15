# XLaunch and Virtual Machine Connection with VS Code

This guide explains the steps to set up and connect XLaunch, a Virtual Machine (VM) running Linux Mint, and VS Code for a seamless development environment.
If you are running Windows and want to have a linux envirornment for development this guide will help.

## Prerequisites

* **VS Code**: [Download here](https://code.visualstudio.com/download)
* **Remote - SSH Extension**: Install it from the VS Code marketplace
* **Oracle VirtualBox**: [Download here](https://www.virtualbox.org/wiki/Downloads)
* **XLaunch**: [Download here](https://sourceforge.net/projects/vcxsrv/)

## Step-by-Step Guide

### 1. Setting up VirtualBox

1. Install **VirtualBox** and create a virtual machine (VM).
2. Install **Linux Mint / Ubuntu** inside the VM.
  * Download Here:
    * **[Linux Mint](https://linuxmint.com/)**
    * **[Ubuntu](https://ubuntu.com/)**
   
3. Configure VM network settings:
   * Go to `Settings` → `Network`
   * Enable **Adapter 2** and select **NAT**
   * Enable **Adapter 3** and select **Host-Only Adapter**
     In the second option choose **VirtualBox Ethernet Adapter**

### 2. Enabling 3D Acceleration

1. Go to `Settings` → `Display`
2. Enable the **3D Acceleration** checkbox

## 3 Automated Setup Script (This will Install and Configure required tools and packages)

### Open Terminal in VM and Clone this repository and run the script as mentioned in this guide

### Prerequisites
- Ubuntu or Linux Mint
- sudo privileges
- Internet connection

### Usage
1. Save the script as `vm_dev_setup.sh` or clone this repository and run the script
2. Make it executable:
   ```bash
   chmod +x vm_dev_setup.sh
3. Run with `sudo`:
   ```bash
   sudo ./vm_dev_setup.sh
   
* What the Script Does
- Checks and installs system prerequisites
- Configures SSH
- Sets up network interfaces
- Configures X11 Forwarding
- Enables firewall
- Installs development tools

### 4. Connecting VS Code to VM

1. Open VS Code and install the **Remote - SSH** extension.
2. Click the **Remote SSH** icon and add a new host:
   ```
   hostname@192.168.56.xxx
   ```
3. `hostname` = Your system's hostname, x = number of your system's IP Address.
4. Enter your Linux Mint login credentials when prompted.
5. After successful connection you should see $ sign, In Vscode use: Ctrl + `  and select terminal to see the $ sign

### 5. Setting up XLaunch

1. Install **XLaunch** on your host machine.
2. Run XLaunch and select the following options:
   * `Next` → `Next` → **Disable Access Control** (check this box) → `Finish`
3. In Vscode terminal write following script to setup XDISPLAY.
   * `export DISPLAY=192.168.56.1:0.0`
5. Verify the setup by running:
   ```bash
   $ xeyes
   ```
   * A pair of animated eyes should appear, confirming the connection.

### 6. Below mentioned things should be repeated everytime when Reoppening / Restarting VirtualBox
* Use `ifconfig` to see `NETWORK_INTERFACE_NAME` IPv4 address will be visible under this
* Write this command, example: $`dhclient -v enp0s8` or $`dhclient -v NETWORK_INTERFACE_NAME`
  
  ## If XLaunch is not required for your deveopment envirornment skip below steps
     * Reopening XLaunch and Disabling access control (Reffer **5. Setting up XLaunch** Step 2:)
     * Write this command $`export DISPLAY=192.168.56.1:0.0` and use `xeyes` to verify the Setup

## Troubleshooting

### All IP Address and Port Numbers in this guide are used as an example and should not be treated as your system's IP Address / NETWORK_INTERFACE_NAME

### 1. SSH Connection Issues

* Ensure the SSH service is running inside the VM:
  ```bash
  $ service ssh start
  ```
* Verify the network port and IP address:
  ```bash
  $ ifconfig
  ```
* If network is not configured, use:
* `enp0s9` is given as an example, in your system this might be diffrent use `ifconfig` from previous step to know the NETWORK_INTERFACE_NAME name
  ```bash
  $ dhclient -v enp0s9
  ```
  When used `ifconfig` IPv4 Adress will be visible Ex: `192.168.56.103` under NETWORK_INTERFACE_NAME `enp0s8` during network configuration using `dhclient`
  this `enp0s8` NETWORK_INTERFACE_NAME should be selected, if used different NETWORK_INTERFACE_NAME configuration will fail and ssh connection will fail

### 2. Display Not Working

* Confirm that 3D acceleration is enabled in the VM settings.
* Check if XLaunch is running on your host machine.
* Ensure **Disable Access Control** is checked in XLaunch settings.

## Screenshots and References

* Add screenshots of the setup process (e.g., network settings, SSH configuration, and XLaunch test).
* Official documentation:
  - [VS Code Remote SSH](https://code.visualstudio.com/docs/remote/ssh)
  - [VirtualBox Network Setup](https://www.virtualbox.org/manual/ch06.html)

## Notes

- Always ensure your software is up to date.
- Take care when modifying system settings.
- Backup your VM and important data before making significant changes.

## Troubleshooting Tips

1. Restart services if you encounter unexpected issues.
2. Double-check network configurations.
3. Verify firewall settings may be blocking connections.
4. If you encounter error while installing virtualbox
   Example: Missing Dependencies Python Core / win32api make sure to install python, If Python is installed use `pip install pywin32`
5. If you encounter **Microsoft Visual C++ 2019 Redistributable** Error,
  Install the package from here - [Microsoft Visual C++ 2019 Redistributable](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170#latest-microsoft-visual-c-redistributable-version)
   
## Contributions

Contributions and improvements to this guide are welcome! Please open an issue or submit a pull request.
