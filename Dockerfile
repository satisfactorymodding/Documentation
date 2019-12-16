FROM node:alpine as build

WORKDIR /app

COPY package.json package.json
COPY yarn.lock yarn.lock

RUN yarn install

COPY . .

RUN yarn run build


FROM nginx

WORKDIR /app

COPY --from=build /app/build/site /usr/share/nginx/html
