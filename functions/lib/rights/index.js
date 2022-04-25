"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getRightId = exports.listPossibleRights = void 0;
const database_1 = require("../database");
exports.listPossibleRights = async () => {
    const rights = await database_1.default.firestore().collection('right').get();
    return rights.docs.map((right) => {
        return Object.assign({ id: right.id }, right.data());
    });
};
exports.getRightId = async (right) => {
    const rights = await database_1.default.firestore().collection('right').where('action', '==', right).get();
    if (rights.size !== 1) {
        throw new Error('Invalid right');
    }
    return rights.docs[0].id;
};
//# sourceMappingURL=index.js.map