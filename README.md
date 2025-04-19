# Development Envirornment for Web, Desktop, GUI applications with linux terminal support in Windows Host with VirtualBox, vscode, Xserver (XDisplay)

## Development Envirornment Architecture Overview

## Windows Host => VirtualBox : Linux Mint (Guest OS) => vscode => Xlaunch

## System Overview

This document provides the details and setup instructions for the Virtual Machine running **Linux Mint 21.1 Vera** (based on Ubuntu 22.04).

## Host System Details

- **Host OS:** Windows 11 (64-bit)
- **Processor:** Intel Core i5-8365U
- **RAM:** 8GB
- **Virtualization Support:** Enabled
- **Python Dependency:**
  - **_Python_ must be installed** on the Host OS for VirtualBox to function properly.
  - If *python* is removed, VirtualBox will not function properly or may not work as expected.
  - Install Python from the official [Python website](https://www.python.org/).
  - **PyWin32 library** is essential for proper VirtualBox operation and should be installed In Host System CMD via:
    ```sh
    pip install pywin32
    ```

## Virtual Machine Specifications

- **OS:** Linux Mint 21.1 Vera (Ubuntu 22.04)
- **Kernel Version:** 5.15.0-130-generic x86_64
- **Virtualization Platform:** VirtualBox, Download from [Here](https://www.virtualbox.org/)
- **CPU:** Intel Core i5-8365U (Single Core Assigned)
- **RAM:** 4 GiB
- **Storage:** 60 GiB VirtualBox Hard Disk
- **Network Adapters:**
  - **Primary Adapter:** Intel 82540EM Gigabit Ethernet (1000 Mbps, Full Duplex)
  - **Secondary Adapter:** Intel 82540EM Gigabit Ethernet (1000 Mbps, Full Duplex)

## Checking Virtual Machine Logs and Python Dependency

To check VirtualBox logs and see how it relies on Python:

1. Open **VirtualBox** and go to **Machine > Show Log**.
2. Look for any Python-related errors in the **VBox.log** file.
3. To check the Python version VirtualBox uses, run:
   ```sh
   python --version
   ```
   or
   ```sh
   where python
   ```

## XLaunch & X Display Configuration

XLaunch is used to enable graphical applications on the VM through an X server. To set it up:

1. **Install X Server on Host OS (Windows)**:
   - Download and install **VcXsrv Windows X Server** from [here](https://sourceforge.net/projects/vcxsrv/).
2. **Configure XLaunch:**
   - Open **XLaunch** and select **Multiple Windows Mode**.
   - Set Display Number to **0**.
   - Enable **Disable Access Control**.
   - Click **Finish** to start the X Server.
3. **Configure the VM to use X11 Forwarding:**
   - Install necessary dependencies:
     ```sh
     sudo apt update && sudo apt install xauth x11-xserver-utils x11-apps
     ```
   - Enable X11 Forwarding:
     ```sh
     export DISPLAY=192.168.193.1:0
     ```
   - Run a GUI application to test:
     ```sh
     xclock
     ```
   - If `xclock` runs successfully, add the following line to **.bashrc** to persist the configuration:
     ```sh
     echo 'export DISPLAY=192.168.193.1:0' >> ~/.bashrc
     ```
   - Ensure `xclock` is installed in the guest OS:
     ```sh
     sudo apt install x11-apps
     ```

## VS Code SSH Configuration

VS Code supports SSH communication through the **Remote - SSH** extension, allowing direct access to the VM. To set it up:

1. Install **Visual Studio Code** on the Host OS from [here](https://code.visualstudio.com/).
2. Install the **Remote - SSH** extension in VS Code.
3. Open VS Code and press **Ctrl + Shift + P**, then search for:
   ```sh
   Remote-SSH: Connect to Host
   ```
4. Add a new SSH connection with:
   ```sh
   ssh user@192.168.193.1
   ```
5. Once connected, VS Code will allow you to edit and manage files in the VM directly.

## Setup Instructions

### 1. Installing Linux Mint on VirtualBox

1. Download the **Linux Mint 21.1 Vera ISO** from the official site.
2. Create a new VM in **VirtualBox** with the following settings:
   - Type: **Linux**
   - Version: **Ubuntu (64-bit)**
   - Memory: **6GB (recommended)**
   - Storage: **25GB (dynamically allocated)**
3. Attach the ISO file and boot the VM to install Linux Mint.

### 2. Configuring Virtual Machine Performance

- **Increase CPU & RAM Allocation:**
  - Go to **VirtualBox Settings > System**
  - Increase **Processor Count** to at least **2 Cores**
  - Increase **RAM** to **6GB or more** (if available)
- **Enable 3D Acceleration for Better Graphics Performance:**
  - Go to **VirtualBox Settings > Display**
  - Enable **3D Acceleration**
  - Increase **Video Memory** to **128MB or higher**

### 3. Network Configuration

- **Adapter 1 (Primary Network - NAT):**
  - Provides internet access inside the VM.
- **Adapter 2 (Host-Only Network - 192.168.193.1):**
  - Used for direct communication between the Host and VM.
- Verify network connectivity using:
  ```sh
  ip a
  ping google.com
  ```

### 4. Enabling Clipboard & File Sharing

- Install **VirtualBox Guest Additions**:
  ```sh
  sudo apt update && sudo apt install virtualbox-guest-utils virtualbox-guest-x11 virtualbox-guest-dkms
  ```
- Enable **Bidirectional Clipboard & Drag-and-Drop** in **VirtualBox Settings > General > Advanced**.

### 5. Setting Up SSH Access (Optional)

- Install SSH Server in VM:
  ```sh
  sudo apt install openssh-server
  sudo systemctl enable ssh
  sudo systemctl start ssh
  ```
- Connect from Host:
  ```sh
  ssh user@192.168.193.1
  ```

## Optimization & Maintenance

- **Update System Regularly:**
  ```sh
  sudo apt update && sudo apt upgrade -y
  ```
- **Clear Unused Packages:**
  ```sh
  sudo apt autoremove && sudo apt clean
  ```
- **Check System Resource Usage:**
  ```sh
  htop
  ```

## Troubleshooting

- **If network doesn’t work:**
  ```sh
  sudo dhclient enp0s3
  ```
- **If VM is slow, increase RAM & CPU allocation in VirtualBox settings.**
- **Check logs for issues:**
  ```sh
  dmesg | tail -50
  ```

---
This guide provides the essential setup and optimization steps for your Linux Mint Virtual Machine. Feel free to modify configurations based on your requirements!
