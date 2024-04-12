@echo off
REM Set CMD encoding to UTF-8 to correctly handle Docker outputs
chcp 65001

REM Check if the Docker network "image-service" exists and create it if not
docker network ls | find "image-service" > nul || docker network create image-service

REM Build the Docker image from the Dockerfile in the current directory
docker build -t image-service -f Dockerfile .

REM Remove the existing container if it exists
docker rm -f image-service

REM Run the Docker container with timezone settings and connect it to the "image-service" network
docker run -d --name image-service -e TZ=Asia/Shanghai --network image-service image-service

REM Echo Done to indicate the script has finished executing
echo Done
