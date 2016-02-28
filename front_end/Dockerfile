FROM node:5.6.0

RUN mkdir /app
WORKDIR /app

COPY package.json /app
RUN npm install

COPY . /app
EXPOSE 8080

CMD ["npm", "start"]
