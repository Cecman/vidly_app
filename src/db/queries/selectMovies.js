const db = require('../connection');

const findAllMovies = async () => {
  const sql = 'SELECT * FROM movies';

  const foundMovies = await new Promise((resolve, reject) => {
    db.query(sql, (err, movies) => {
      if (err) reject(err);
      resolve(movies);
    });
  });

  return foundMovies;
};

module.exports = findAllMovies;
