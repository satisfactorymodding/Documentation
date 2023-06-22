FROM node:alpine as build

ARG BUILD=build

WORKDIR /app

RUN npm install -g pnpm

COPY package.json package.json
COPY pnpm-lock.yaml pnpm-lock.yaml

RUN pnpm install

COPY . .

RUN pnpm run $BUILD


FROM nginx

WORKDIR /app

COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build/site /usr/share/nginx/html
