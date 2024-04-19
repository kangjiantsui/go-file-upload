export LANG=C.UTF-8
export LC_ALL=C.UTF-8

go build -o build/go-file-upload cmd/main.go

docker build -t image-service -f Dockerfile .