FROM node:18.0.0 AS base_image

WORKDIR /usr/src/app

COPY . .

ENV NODE_OPTIONS=--openssl-legacy-provider

RUN npm install

RUN npm run build

FROM node:18.0.0-alpine

WORKDIR /usr/src/app

COPY --from=base_image /usr/src/app .

ARG API_KEY

ENV TMDB_KEY=${API_KEY}

EXPOSE 3000

CMD ["npm", "start"]