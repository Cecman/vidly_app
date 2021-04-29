const homeRoute = require('../api/routes/home');
const getMovies = require('../api/routes/movies');

module.exports = server => {
  server.route(homeRoute);
  server.route(getMovies);
};
