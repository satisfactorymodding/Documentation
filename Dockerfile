FROM node:alpine as build

ARG BUILD=build

WORKDIR /app

COPY package.json package.json
COPY yarn.lock yarn.lock

RUN yarn install

COPY . .

RUN yarn run $BUILD


FROM nginx

WORKDIR /app

COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build/site /usr/share/nginx/html
