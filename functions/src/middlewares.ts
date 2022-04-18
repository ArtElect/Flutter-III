import { RequestHandler } from 'express';
import { validate } from 'class-validator';
import { plainToClass } from 'class-transformer';

export function validationMiddleware(type: any, where: string): RequestHandler {
  return async (req, _res, next) => {
    let obj = {};
    if (where === 'body') {
      obj = plainToClass(type, req.body);
    } else if (where === 'query') {
      obj = plainToClass(type, req.query);
    } else {
      throw new Error('Trying to use the request validation middleware on unknown field.');
    }

    const errors = await validate(obj);
    if (errors.length !== 0) {
      const message = JSON.stringify(errors);
      next(new Error(message));
    }

    next();
  };
}
