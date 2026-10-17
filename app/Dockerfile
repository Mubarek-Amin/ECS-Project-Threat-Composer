#base image multi 
FROM node:20-bookworm-slim AS builder

WORKDIR /app

COPY package.json yarn.lock ./ 

RUN yarn install --frozen-lockfile

COPY . .

RUN yarn build

FROM node:20-bookworm-slim AS runner

RUN yarn global add serve

COPY --from=builder app/build/ /build

RUN useradd nonroot

USER nonroot

CMD ["serve", "-s", "build" ]
