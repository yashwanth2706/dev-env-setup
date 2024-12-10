# XLaunch and Virtual Machine Connection with VS Code

This guide explains the steps to set up and connect XLaunch, a Virtual Machine (VM) running Linux Mint, and VS Code for a seamless development environment.

## Prerequisites

* **VS Code**: [Download here](https://code.visualstudio.com/download)
* **Remote - SSH Extension**: Install it from the VS Code marketplace
* **Oracle VirtualBox**: [Download here](https://www.virtualbox.org/wiki/Downloads)
* **XLaunch**: [Download here](https://sourceforge.net/projects/xming/)

## Step-by-Step Guide

### 1. Setting up VirtualBox

1. Install **VirtualBox** and create a virtual machine (VM).
2. Install **Linux Mint** inside the VM.
3. Configure VM network settings:
   * Go to `Settings` → `Network`
   * Enable **Adapter 3** and select **Host-Only Adapter**
   * Choose **VirtualBox Ethernet Adapter** in the second option

### 2. Enabling 3D Acceleration

1. Go to `Settings` → `Display`
2. Enable the **3D Acceleration** checkbox

### 3. Configuring Linux Mint (Inside the VM)

1. Open the terminal and install the SSH client:
   ```bash
   $ sudo apt install openssh-client
   ```

2. Check SSH status to ensure it's active:
   ```bash
   $ service ssh status
   ```

3. Find your VM's network port and IP address:
   ```bash
   $ ifconfig
   ```
   * Identify the correct port (in this case, `enp0s9`)

4. Configure the network IP:
   ```bash
   $ dhclient -v enp0s9
   ```

5. Verify the IP address:
   ```bash
   $ ifconfig
   ```
   * Note the IPv4 address for the `enp0s9` port (e.g., `192.168.56.103`)

### 4. Connecting VS Code to VM

1. Open VS Code and install the **Remote - SSH** extension.
2. Click the **Remote SSH** icon and add a new host:
   ```
   yashwanth@192.168.56.103
   ```
3. Enter your Linux Mint login credentials when prompted.

### 5. Setting up XLaunch

1. Install **XLaunch** on your host machine.
2. Run XLaunch and select the following options:
   * `Next` → `Next` → **Disable Access Control** (check this box) → `Finish`
3. Verify the setup by running:
   ```bash
   $ xeyes
   ```
   * A pair of animated eyes should appear, confirming the connection.

## Troubleshooting

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
  ```bash
  $ dhclient -v enp0s9
  ```

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

## Contributions

Contributions and improvements to this guide are welcome! Please open an issue or submit a pull request.
