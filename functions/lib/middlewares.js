"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.validationMiddleware = void 0;
const class_validator_1 = require("class-validator");
const class_transformer_1 = require("class-transformer");
function validationMiddleware(type, where) {
    return async (req, _res, next) => {
        let obj = {};
        if (where === 'body') {
            obj = class_transformer_1.plainToClass(type, req.body);
        }
        else if (where === 'query') {
            obj = class_transformer_1.plainToClass(type, req.query);
        }
        else {
            throw new Error('Trying to use the request validation middleware on unknown field.');
        }
        const errors = await class_validator_1.validate(obj);
        if (errors.length !== 0) {
            const message = JSON.stringify(errors);
            next(new Error(message));
        }
        next();
    };
}
exports.validationMiddleware = validationMiddleware;
//# sourceMappingURL=middlewares.js.map