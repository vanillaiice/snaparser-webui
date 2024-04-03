FROM node:21.7-alpine3.18 AS build

ARG API_URL=http://localhost:8888

WORKDIR /app

COPY package*.json ./
RUN npm ci && npm install

ENV VITE_API_URL=$API_URL

COPY . .
RUN npm run build

FROM caddy:2.7.6-alpine

COPY Caddyfile /etc/caddy/Caddyfile

EXPOSE 7777

COPY --from=build /app/build /srv
