"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getAccounts = exports.updateAccount = exports.createAccount = exports.getAccountFromUserId = void 0;
const database_1 = require("../database");
exports.getAccountFromUserId = async (userId) => {
    const accounts = await database_1.default.firestore().collection('account').where('userId', '==', userId).get();
    if (accounts.size === 0) {
        return undefined;
    }
    return Object.assign({ id: accounts.docs[0].id }, accounts.docs[0].data());
};
exports.createAccount = async (data, role) => {
    await database_1.default.firestore().collection('account').add(Object.assign(Object.assign({}, data), { image: '', role }));
    return { message: 'account created' };
};
exports.updateAccount = async (userId, data) => {
    const accounts = await database_1.default.firestore().collection('account').where('userId', '==', userId).get();
    if (accounts.size === 0) {
        return undefined;
    }
    await database_1.default.firestore().collection('account').doc(accounts.docs[0].id).update(data);
    return { message: 'account updated' };
};
exports.getAccounts = async () => {
    const accounts = await database_1.default.firestore().collection('account').get();
    return accounts.docs.map((account) => {
        return Object.assign({ id: account.id }, account.data());
    });
};
//# sourceMappingURL=index.js.map