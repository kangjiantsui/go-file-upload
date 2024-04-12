docker rm -f kj-nginx
docker run -d -p 15408:15408 --name kj-nginx \
-v ./nginx:/etc/nginx \
-e TZ=Asia/Shanghai \
nginx