GOOS=linux GOARCH=amd64 go build -o build/go-file-upload cmd/main.go

docker build -t image-service -f Dockerfile .
docker rm -f image-service
docker run -d --name image-service -p 5408:5408 image-service
