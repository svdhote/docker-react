From node:alpine as builder
ENV http_proxy http://genproxy.corp.amdocs.com:8080/
ENV FTP_PROXY http://genproxy.corp.amdocs.com:8080/
ENV ftp_proxy http://genproxy.corp.amdocs.com:8080/
ENV HTTPS_PROXY http://genproxy.corp.amdocs.com:8080/
ENV https_proxy http://genproxy.corp.amdocs.com:8080/
ENV no_proxy localhost,127.0.0.1,.svc,.local,.amdocs.com,.sock,docker.sock,localaddress,.localdomain.com,illinlic01,indlinsls,linvc04

WORKDIR '/app'
COPY package.json
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
