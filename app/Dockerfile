#base image multi 
FROM node:20-bookworm-slim AS builder

WORKDIR /app

COPY package.json yarn.lock ./ 

RUN yarn install --frozen-lockfile

COPY . .

RUN yarn build

#nginx runner used to decrease CVEs from the node pks dependencies
FROM nginx:alpine AS runner

RUN apk update && apk upgrade --no-cache

COPY --from=builder app/build/ /usr/share/nginx/html

COPY nginx.conf etc/nginx/conf.d/default.config

EXPOSE 80


