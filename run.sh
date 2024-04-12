docker build -t image-service -f Dockerfile .
docker rm -f image-service
docker run -d --name image-service -p 5408:5408 -e TZ=Asia/Shanghai  image-service