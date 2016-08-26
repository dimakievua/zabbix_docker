# zabbix_docker
Docker file to create zabbix container with external mysql server

Aim of this project is to create Dockerfile to create container with zabbix installed. Configuration DB is mysql installed on another docker container. 

Main issue is to create and upload configuration into mysql. Since during image creation DB server IP must be used I put it in docker file manually. Getting it with:
docker inspect <mysql container name> | grep -m1 -iw "ipaddress" | cut -c 26- | egrep -o '([0-9]+\.){3}[0-9]+'
After configuration uploading zabbix server installed and container could be run.
