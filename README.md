# Dodger-min
A fork of Ryan "Ghost" Voit's Dodger.py

Dodger is designed to quickly dodge basic MAC and hostname filtering without needing to take time to reset network configuration on your linux based computer. This fork is written in bash.

# Dependencies

In order for this script to work, simply have the following installed:

dhclient
hostnamectl
macchanger 
iproute2

# Usage

chmod +x Dodger.sh
./Dodger.sh {interface}

Example:
./Dodger.sh wlan0