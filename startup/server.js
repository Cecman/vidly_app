require('dotenv').config();
const Hapi = require('@hapi/hapi');
const router = require('./router');
require('../src/db/connection');

const port = process.env.PORT || 5000;

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
