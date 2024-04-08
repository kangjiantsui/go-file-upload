package main

import (
	"fmt"
	"io"
	"log"
	"mime/multipart"
	"net/http"
	"os"
	"path/filepath"
)

func uploadFile(w http.ResponseWriter, r *http.Request) {
	_ = r.ParseMultipartForm(10 << 20) // 10 MB
	file, handler, err := r.FormFile("imageFile")
	if err != nil {
		fmt.Println("Error Retrieving the File")
		log.Println(err)
		return
	}
	defer func(file multipart.File) {
		_ = file.Close()
	}(file)

	fmt.Printf("Uploaded File: %+v\n", handler.Filename)
	fmt.Printf("File Size: %+v\n", handler.Size)
	fmt.Printf("MIME Header: %+v\n", handler.Header)

	// 读取文件内容
	fileBytes, err := io.ReadAll(file)
	if err != nil {
		log.Println(`读取文件失败,`, err)
	}

	savePath := "/app/images/" + handler.Filename

	// 将文件保存到指定的位置
	err = os.WriteFile(savePath, fileBytes, 0644)
	if err != nil {
		log.Println(`保存文件失败,`, err)
	}

	_, _ = fmt.Fprintf(w, "文件上传成功！")
}

func listImages(w http.ResponseWriter, r *http.Request) {
	imagesDir := "/app/images/"
	files, err := os.ReadDir(imagesDir)
	if err != nil {
		log.Println("读取目录失败:", err)
		http.Error(w, "无法读取目录", http.StatusInternalServerError)
		return
	}

	for _, file := range files {
		if !file.IsDir() { // 确保是文件而不是目录
			_, _ = fmt.Fprintln(w, file.Name())
		}
	}
}

func downloadImage(w http.ResponseWriter, r *http.Request) {
	fileName := r.URL.Query().Get("filename")
	if fileName == "" {
		http.Error(w, "文件名参数缺失", http.StatusBadRequest)
		return
	}

	filePath := "/app/images/" + fileName
	if _, err := os.Stat(filePath); os.IsNotExist(err) {
		http.Error(w, "文件不存在", http.StatusNotFound)
		return
	}

	// 基于文件扩展名推断Content-Type，而不是使用application/octet-stream
	contentType := "application/octet-stream" // 默认值
	switch filepath.Ext(fileName) {
	case ".jpg", ".jpeg":
		contentType = "image/jpeg"
	case ".png":
		contentType = "image/png"
	case ".gif":
		contentType = "image/gif"
		// 可以根据需要添加更多的文件类型
	}
	w.Header().Set("Content-Type", contentType)

	// 不设置Content-Disposition头部，或者将其设置为inline也可以
	// w.Header().Set("Content-Disposition", "inline; filename="+fileName)

	http.ServeFile(w, r, filePath)
}

func setupRoutes() {
	http.HandleFunc("/upload", uploadFile)
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, "html/upload.html")
	})
	http.HandleFunc("/image-list", func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, "html/image-list.html")
	})
	http.HandleFunc("/list", listImages)
	http.HandleFunc("/download", downloadImage)
}

func main() {
	setupRoutes()
	fmt.Println("Server starting on port 5408...")
	if err := http.ListenAndServe(":5408", nil); err != nil {
		fmt.Printf("Error starting server: %s\n", err)
	}
}
