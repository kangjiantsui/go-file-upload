# 设置编码为 UTF-8 以正确处理 Docker 输出
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 如果不存在名为 "image-service" 的 Docker 网络，则创建它
$network = docker network ls | Select-String "image-service"
if (-not $network) {
    docker network create image-service
}

# 从当前目录的 Dockerfile 构建 Docker 镜像
docker build -t image-service -f Dockerfile .

# 如果已存在，则删除名为 "image-service" 的容器
docker rm -f image-service

# 运行 Docker 容器，设置时区，并将其连接到 "image-service" 网络
docker run -d --name image-service `
    -e TZ=Asia/Shanghai `
    --network image-service `
    image-service

# 输出 "完成" 表示脚本已执行完毕
Write-Host "完成"
