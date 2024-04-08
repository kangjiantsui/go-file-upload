FROM alpine:latest

COPY build/go-file-upload /app/
COPY ../html /app/html

WORKDIR /app
RUN mkdir -p /app/images && \
  chmod 755 /app/images


# 暴露端口5408
EXPOSE 5408

# 运行应用
CMD ["./go-file-upload"]