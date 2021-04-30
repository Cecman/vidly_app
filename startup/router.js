const homeRoute = require('../api/routes/home');
const { getMovies, postMovie } = require('../api/routes/movies');

module.exports = server => {
  server.route(homeRoute);
  server.route(getMovies);
  server.route(postMovie);
};
