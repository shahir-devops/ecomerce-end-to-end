FROM node:18 AS build
WORKDIR /app
COPY package-lock.json package.json ./
RUN npm install
RUN npm run build

