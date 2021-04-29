require('dotenv').config();
const port = process.env.PORT || 5000;
const Hapi = require('@hapi/hapi');
const db = require('../src/db/db');
const router = require('./router');


const init = async () => {
  const server = Hapi.server({
    port: port,
    host: process.env.HOST,
  });

  router(server);

  await server.start();
  console.log(`Server running on port ${port}`);
};

//logger
process.on('unhandledRejection', err => {
  console.log(err);
  process.exit(1);
});

module.exports = init;
