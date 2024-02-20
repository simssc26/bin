#!/usr/bin/bash

# Set wifi network name, username, password, and captive portal URL
wifi_name="FSB1784B"
username="Friends020524"
password="Feb5114arch"
url="wifi.friendsbalt.org/login.html"

# Turn wifi off, back on, and the connect to the guest network
nmcli radio wifi off
nmcli radio wifi on
sleep 1
nmcli device wifi connect "$wifi_name"

# Set the value of the `au_pxytimetag` variable
au_pxytimetag=$(curl -s "$url" | grep -oP '(?<=name=au_pxytimetag value=")\d+(?=">)')
echo $au_pxytimetag

# Submit guest credentials to the captive portal
curl -X POST -d "username=$username" -d "password=$password" -d "au_pxytimetag=$au_pxytimetag" "$url" | grep -oP '(?<=<h1>)\w.*(?=</h1>)'

# Check connection
ping -c 1 https://archlinux.org/
