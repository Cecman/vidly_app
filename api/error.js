const Boom = require('@hapi/boom');

const asyncTcHandler = handler => {
  return async (request, h) => {
    try {
      return await handler(request, h);
    } catch (err) {
      return Boom.badImplementation('Something went wrong...');
    }
  };
};

module.exports = asyncTcHandler;
