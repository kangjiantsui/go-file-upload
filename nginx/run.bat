@echo off
REM Set CMD encoding to UTF-8 to handle Docker outputs correctly
chcp 65001

REM Create a Docker network if it does not exist
docker network ls | find "image-service" > nul || docker network create image-service

REM This batch file removes an old Docker container and runs a new one with specified configurations.

REM Remove the existing Docker container
docker rm -f image-service-nginx

REM Run a new Docker container with specified port and volume mappings and connect it to the image-service network
docker run -d -p 15408:15408 --name image-service-nginx ^
-v %cd%\nginx:/etc/nginx ^
-e TZ=Asia/Shanghai ^
--network image-service ^
nginx

REM Echo Done to indicate the script has finished executing
echo Done