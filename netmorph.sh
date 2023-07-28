#!/usr/bin/sudo /bin/bash

if [ -z $1 ]; then
    echo "Usage: ./netmorph.sh {interface}"
    exit 1
fi

# Check if device exists
ip address show dev $1
if [ $? -eq 1 ]; then
  echo "Please provide a valid interface"
  exit 1
fi



# Drop old IP and wait a bit
echo "Dropping IP..."
dhclient -r $1
if [ $? -eq 1 ]; then
  echo "Releasing ip on device $1 failed. Please try again."
  exit 1
fi
sleep 4

# Set input interface down, then set random MAC address and hostname
echo "Randomizing MAC & hostname.."
ip link set $1 down
macchanger -r $1
if [ $? -eq 1 ]; then
  echo "Randomizing MAC on device $1 failed"
  exit 1
fi

hostnamectl hostname $(openssl rand -base64 12)
if [ $? -eq 1 ]; then
  echo "Randomizing hostname on device $1 failed"
  exit 1
fi


# Set input interface up, renew IP.
echo "Renewing IP..."
ip link set $1 up
dhclient $1
if [ $? -eq 1 ]; then
  echo "Renewing ip on device $1 failed"
  exit 1
fi
echo "Done!"
