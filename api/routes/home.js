const homeHandler = require('../handlers/homeHandlers');

const homeRoute = {
  method: 'GET',
  path: '/',
  handler: homeHandler,
};

module.exports = homeRoute;
