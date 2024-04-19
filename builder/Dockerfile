# 使用 Ubuntu 官方的基础镜像
FROM ubuntu:20.04

# 设置时区环境变量，避免在构建过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 替换为阿里云的 Ubuntu 镜像源
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

# 更新软件包列表
RUN apt-get update

# 安装 OpenJDK 11
RUN apt-get install -y openjdk-11-jdk

# 安装 Go 1.21
# 首先下载 Go 1.21 的 tar.gz 包
RUN apt-get install -y wget
RUN wget https://mirrors.ustc.edu.cn/golang/go1.21rc2.linux-amd64.tar.gz -O /tmp/go1.21.linux-amd64.tar.gz

# 解压 Go 包到 /usr/local
RUN tar -xzf /tmp/go1.21.linux-amd64.tar.gz -C /usr/local

# 设置 Go 环境变量
ENV PATH="${PATH}:/usr/local/go/bin"

# 安装 Git
RUN apt-get install -y git

# 清理缓存
RUN rm -rf /var/lib/apt/lists/* /tmp/go1.21.linux-amd64.tar.gz
