#!/bin/bash

# Check whether app container is exist
docker ps |grep myweb_app
if [ $? -eq 0 ]
then
   docker stop myweb_app && docker rm -v myweb_app 
fi

# Start app container with latest image
docker run -d -p 8880:8080 --name myweb_app ${env.APP_IMG}


# Check whether web container is exist
docker ps |grep myweb_web
if [ $? -eq 0 ]
then
   docker stop myweb_web && docker rm -v myweb_web 
fi

# Start web container with latest image
docker run -d -p 8080:80 --name myweb_web ${env.WEB_IMG} 
