docker build -t custom-httpd -f Dockerfile .

docker images

docker run -d -p 8080:80 custom-httpd

http://localhost:8080