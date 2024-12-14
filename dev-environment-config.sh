#!/bin/bash

# VM Development Environment Setup Script
# Version: 1.0.0
# Author: Yashwanth A
# Description: Automated setup for VM development environment

# Color codes for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${GREEN}[✓] $1${NC}"
}

# Error handling function
error() {
    echo -e "${RED}[✗] ERROR: $1${NC}"
    exit 1
}

# Prerequisite check function
check_prerequisites() {
    echo -e "${YELLOW}Checking system prerequisites...${NC}"
    
    # Check for required packages
    REQUIRED_PACKAGES=("openssh-client" "net-tools" "curl" "wget")
    for pkg in "${REQUIRED_PACKAGES[@]}"; do
        if ! dpkg -s "$pkg" >/dev/null 2>&1; then
            echo "Installing $pkg..."
            sudo apt-get install -y "$pkg" || error "Could not install $pkg"
        fi
    done

    log "All prerequisites are installed"
}

# SSH Configuration
configure_ssh() {
    echo -e "${YELLOW}Configuring SSH...${NC}"
    
    # Ensure SSH service is installed and running
    sudo apt-get install -y openssh-server
    sudo systemctl enable ssh
    sudo systemctl start ssh

    # Configure SSH config for better security
    sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    sudo systemctl restart ssh

    log "SSH configured successfully"
}

# Network Configuration
configure_network() {
    echo -e "${YELLOW}Configuring Network...${NC}"
    
    # Detect network interfaces
    INTERFACES=$(ip -o link show | awk -F': ' '{print $2}' | grep -v "lo")
    
    echo "Available Network Interfaces:"
    echo "$INTERFACES"

    read -p "Enter the interface to configure (e.g., enp0s9): " NETWORK_INTERFACE

    # Configure DHCP for the specified interface
    sudo dhclient -v "$NETWORK_INTERFACE" || error "Network configuration failed"

    # Display network configuration
    ip addr show "$NETWORK_INTERFACE"

    log "Network configured for $NETWORK_INTERFACE"
}

# X11 Forwarding Setup
configure_x11_forwarding() {
    echo -e "${YELLOW}Configuring X11 Forwarding...${NC}"
    
    # Ensure X11 packages are installed
    sudo apt-get install -y xauth x11-apps

    # Modify SSH config for X11 Forwarding
    sudo sed -i 's/#X11Forwarding no/X11Forwarding yes/' /etc/ssh/sshd_config
    sudo systemctl restart ssh

    # Test X11 Forwarding
    xeyes &
    sleep 2
    killall xeyes

    log "X11 Forwarding configured and tested"
}

# Firewall Configuration
configure_firewall() {
    echo -e "${YELLOW}Configuring Firewall...${NC}"
    
    # Install UFW if not present
    sudo apt-get install -y ufw

    # Allow SSH
    sudo ufw allow ssh
    sudo ufw enable

    log "Firewall configured to allow SSH"
}

# Development Tools Installation
install_dev_tools() {
    echo -e "${YELLOW}Installing Development Tools...${NC}"
    
    # Core development tools
    sudo apt-get update
    sudo apt-get install -y \
        build-essential \
        git \
        curl \
        wget \
        software-properties-common

    # Optional: Install programming language runtimes
    # Uncomment and modify as needed
    # sudo apt-get install -y python3 python3-pip
    # sudo apt-get install -y nodejs npm

    log "Development tools installed"
}

# Main execution
main() {
    echo -e "${YELLOW}Starting VM Development Environment Setup${NC}"
    
    # Ensure script is run with sudo
    if [[ $EUID -ne 0 ]]; then
       error "This script must be run with sudo privileges"
    fi

    check_prerequisites
    configure_ssh
    configure_network
    configure_x11_forwarding
    configure_firewall
    install_dev_tools

    echo -e "${GREEN}
    ╔═════════════════════════════════════╗
    ║  Setup Complete! 🎉                ║
    ╚═════════════════════════════════════╝
    ${NC}"
}

# Execute main function
main
