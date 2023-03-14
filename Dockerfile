FROM node:19-alpine
ENV NODE_ENV=production

WORKDIR /app

COPY . .

RUN npm install --production

CMD ["node", "index.js"]
