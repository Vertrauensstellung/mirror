#!/bin/bash

### Get OS details ###
osname=$(hostnamectl | grep "Operating System")

if [[ "$osname" == *"Kali"* ]]; then
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list

    curl -fsSL https://download.docker.com/linux/debian/gpg |
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    sudo apt update -y
    sudo apt install -y docker-ce docker-ce-cli containerd.io
elif [[ "$osname" == *"Ubuntu"* ]]; then
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update -y
    sudo apt install docker-ce -y
fi