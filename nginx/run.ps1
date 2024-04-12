# 设置 PowerShell 的编码为 UTF-8 以正确处理 Docker 输出
$OutputEncoding = [System.Text.Encoding]::UTF8

# 检查 Docker 网络是否存在，若不存在则创建
if (-not (docker network ls | Select-String "image-service")) {
    docker network create image-service
}

# 删除旧的 Docker 容器
docker rm -f image-service-nginx

# 使用指定的端口和卷映射运行新的 Docker 容器，并连接到 image-service 网络
docker run -d -p 15408:15408 --name image-service-nginx `
-v "${PWD}/nginx:/etc/nginx" `
-e TZ=Asia/Shanghai `
--network image-service `
nginx

# 输出完成的信息，表明脚本已执行结束
Write-Host "Done"
