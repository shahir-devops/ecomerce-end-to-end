FROM node:18
WORKDIR /app
COPY package-lock.json package.json ./
RUN npm install 
RUN npm install -g pm2
COPY . .
EXPOSE 80
EXPOSE 3000
CMD ["pm2-runtime", "start", "index.js", "--name", "backendapi"]