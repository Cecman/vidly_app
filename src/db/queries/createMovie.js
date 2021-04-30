const db = require('../connection');

const postMovie = async (barCode, dailyRentalRate, numberInStock) => {
  const sql = 'CALL insert_movie(?, ?, ?)';
  const result = await new Promise((resolve, reject) => {
    db.query(sql, [barCode, dailyRentalRate, numberInStock], (err, result) => {
      if (err) reject(err);
      resolve(result);
    });
  });
  return result;
};
module.exports = postMovie;
