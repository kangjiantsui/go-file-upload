# 使用 Ubuntu 官方的基础镜像
FROM ubuntu:20.04

# 设置时区和语言环境变量，避免在构建过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    TZ=Asia/Shanghai

# 替换为阿里云的 Ubuntu 镜像源，安装语言包和设置时区
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y locales && \
    locale-gen en_US.UTF-8 && \
    apt-get install -y tzdata && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# 安装 OpenJDK 11，Go 1.21，wget 和 git
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk wget git && \
    wget https://mirrors.ustc.edu.cn/golang/go1.21rc2.linux-amd64.tar.gz -O /tmp/go1.21.linux-amd64.tar.gz && \
    tar -xzf /tmp/go1.21.linux-amd64.tar.gz -C /usr/local

# 单独一步安装 Docker CLI
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce-cli

# 设置 Go 环境变量
ENV PATH="${PATH}:/usr/local/go/bin"

# 完成设置
RUN echo "Docker image is ready to use."
