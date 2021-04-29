const db = require('../../src/db/connection');

const getAllMovies = async (request, h) => {
  const sql = 'SELECT * FROM movies';
  db.query(sql, (err, results) => {
    if (err) throw err;
    console.log(results);
  });
  return 'movies should be here';
};

module.exports = getAllMovies;