const tcHandler = require('../error');
const getAllMovies = require('../handlers/movieHandlers');

const getMovies = {
  method: 'GET',
  path: '/movies',
  handler: tcHandler(getAllMovies),
};

module.exports = getMovies;
