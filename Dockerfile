FROM node:20-bookworm-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    make \
    g++ \
    python3 \
  && rm -rf /var/lib/apt/lists/*

ENV NODE_ENV=production

WORKDIR /hedgedoc

COPY .yarn .yarn
COPY .yarnrc.yml package.json yarn.lock ./

RUN corepack enable \
  && yarn install --immutable

COPY . .

RUN yarn build \
  && yarn cache clean

EXPOSE 3000

CMD ["yarn", "start"]
