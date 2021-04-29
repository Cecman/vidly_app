const Joi = require('joi');

const moviesSchema = Joi.object({
  barCode: Joi.string().min(10).max(10).required(),
  dailyRentalRate: Joi.number().required(),
  numberInStock: Joi.number().required(),
});

const validate = movie => {
    console.log('validating movie..');
  return moviesSchema.validate(movie);
};

module.exports = validate;
