#stage 1
FROM node:18 as buildStep
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .

#stage 2
FROM httpd as productStep
COPY --from=buildStep /app/build /usr/local/apache2/htdocs/
RUN chown www-data:www-data /usr/local/apache2/htdocs/index.html
ENV LOGFILE=/var/log/httpd/access.log
EXPOSE 80
CMD ["httpd-foreground"]