FROM node:latest
# Inspired from https://fr.vuejs.org/v2/cookbook/dockerize-vuejs-app.html

RUN npm install -g http-server
WORKDIR /web
ADD . .

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
EXPOSE 8080
CMD [ "http-server", "dist" ]