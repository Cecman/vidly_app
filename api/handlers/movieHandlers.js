const findMovies = require('../../src/db/queries/selectMovies');
const Boom = require('@hapi/boom');

const getAllMovies = async (request, h) => {
  const movies = await findMovies();
  if (movies.length < 1) {
    return Boom.notFound('No movies in our DB');
  }
  return h.response(movies);
};

module.exports = getAllMovies;
