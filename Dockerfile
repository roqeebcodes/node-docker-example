# ✅ NEW/FIXED (Recommended for general use)
FROM debian:stable
# OR (Better for Node.js apps)
FROM node:20-slim
# OR (Better for Python apps)
FROM python:3.11-slim

ENV HOME=/home/app

RUN apt-get update && apt-get install htop

COPY package.json package-lock.json $HOME/node_docker/

WORKDIR $HOME/node_docker

RUN npm install --silent --progress=false

COPY . $HOME/node_docker

CMD ["npm", "start"]
