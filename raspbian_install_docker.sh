#!/bin/bash
#Automating installation of docker in Raspbian, Raspberry PI. It´s neccesary sudo rights and Internet Connection
#created by victorrodilla


#"Installing docker" 
if docker --version > /dev/null 2>&1
    then
        echo "Docker is installed in this host! Nothing to do"
else
    i=1;
    curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
fi

# "Create docker group and adding user"
if grep -q docker /etc/group 
    then
        echo "Docker group exist in this host! Nothing to do"
else
    i=1;
    groupadd docker
fi

#Add $USER to docker group
if groups | grep -q docker  
    then
        echo "User **$USER** is in docker group! Nothing to do"
else
    i=1;
    echo gpasswd -a $USER docker
fi


#Apply changes with VM restarting
if [ -z ${i} ];
    then
        echo "Nothing to do!"
else
    echo "Restarting VM to apply changes . . ."
    reboot
fi
