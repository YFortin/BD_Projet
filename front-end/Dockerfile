FROM node:latest
# Inspired from https://fr.vuejs.org/v2/cookbook/dockerize-vuejs-app.html

ARG BACK_END_IP
ENV VUE_APP_BACK_END_IP=$BACK_END_IP
RUN npm install -g http-server
WORKDIR /web
ADD . .

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
EXPOSE 8080
CMD [ "http-server", "dist" ]