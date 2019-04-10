FROM node:latest
# Inspired from https://fr.vuejs.org/v2/cookbook/dockerize-vuejs-app.html

WORKDIR /web
COPY package*.json ./

RUN npm install
RUN npm install -g http-server
COPY . .
RUN npm run build
EXPOSE 8080
CMD [ "http-server", "dist" ]