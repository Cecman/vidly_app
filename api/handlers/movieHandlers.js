const findMovies = require('../../src/db/queries/findMovies');
const postMovie = require('../../src/db/queries/createMovie');
const Boom = require('@hapi/boom');

const getAllMovies = async (request, h) => {
  const movies = await findMovies();
  if (movies[0].length < 1) {
    return Boom.notFound('No movies in our DB');
  }
  return h.response(movies);
};

const createMovie = async (request, h) => {
  const isEntered = await postMovie(
    request.payload.barCode,
    request.payload.price,
    request.payload.stock
  );
  return isEntered;
};

module.exports = { getAllMovies, createMovie };
