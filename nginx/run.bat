@echo off
REM Set CMD encoding to UTF-8 to handle Docker outputs correctly
chcp 65001

REM This batch file removes an old Docker container and runs a new one with specified configurations.

REM Remove the existing Docker container
docker rm -f kj-nginx

REM Run a new Docker container with specified port and volume mappings
docker run -d -p 15408:15408 --name kj-nginx ^
-v %cd%\nginx:/etc/nginx ^
-e TZ=Asia/Shanghai ^
nginx

REM Echo Done to indicate the script has finished executing
echo Done
