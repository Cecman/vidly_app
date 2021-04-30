const tcHandler = require('../error');
const { getAllMovies, createMovie } = require('../handlers/movieHandlers');

const getMovies = {
  method: 'GET',
  path: '/movies',
  handler: tcHandler(getAllMovies),
};

const postMovie = {
  method: 'POST',
  path: '/create/movie',
  handler: tcHandler(createMovie),
};

module.exports = { getMovies, postMovie };
