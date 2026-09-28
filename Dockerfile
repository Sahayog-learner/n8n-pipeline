FROM nginx:alpine

RUN echo '<html><body><h1>Payment Service</h1><p>Docker Hub CI/CD test successful!</p></body></html>' > /usr/share/nginx/html/index.html

EXPOSE 80


