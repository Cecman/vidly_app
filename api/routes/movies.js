const getAllMovies = require('../handlers/movieHandlers');

const getMovies = {
  method: 'GET',
  path: '/movies',
  handler: getAllMovies,
};

module.exports = getMovies;