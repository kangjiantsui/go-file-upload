export LANG=C.UTF-8
export LC_ALL=C.UTF-8
# 设置编译环境变量
export GOOS=linux
export GOARCH=amd64

# 构建 Go 项目
go build -o build/go-file-upload cmd/main.go

# 获取当前时间，格式为：年月日时分，例如 202404151235
TIMESTAMP=$(date +"%Y%m%d%H%M")

# 构建 Docker 镜像
docker build -t image-service -f Dockerfile .

# 使用时间戳标记镜像
docker tag image-service:latest "kangjiantsui/image-service:$TIMESTAMP"

# 同时更新 latest 标签
docker tag image-service:latest kangjiantsui/image-service:latest

# 推送镜像到 Docker Hub
docker push "kangjiantsui/image-service:$TIMESTAMP"
docker push kangjiantsui/image-service:latest

