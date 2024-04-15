docker rm -f image-service
docker rm -f kj-nginx

# 启动 Docker Compose 服务
docker compose up -d
