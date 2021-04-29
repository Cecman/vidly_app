const homeHandler = require('./handlers');

const homeRoute = {
  method: 'GET',
  path: '/',
  handler: homeHandler,
};

module.exports = homeRoute;
