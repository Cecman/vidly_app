require('dotenv').config();
const mysql = require('mysql');

const con = mysql.createConnection({
  host: process.env.HOST,
  user: process.env.DB_HOST,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

con.connect(err => {
  if (err) throw err;
  console.log('Connected to DB');
});

module.exports = con;

