FROM node:latest

RUN git clone https://github.com/Steampunk539/node-js-dummy-test.git

WORKDIR node-js-dummy-test

RUN npm install

EXPOSE 3000

CMD ["sh", "-c", "npm start"] 
