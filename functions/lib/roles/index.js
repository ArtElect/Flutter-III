"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.addRole = exports.listAccountRoles = void 0;
const database_1 = require("../database");
const accounts_1 = require("../accounts");
exports.listAccountRoles = async (userId) => {
    const account = await accounts_1.getAccountFromUserId(userId);
    const accountRef = await database_1.default.firestore().collection('account').doc(account.id);
    const roles = await database_1.default.firestore()
        .collection('role')
        .where('account', '==', accountRef)
        .get();
    return Promise.all(roles.docs.map(async (role) => {
        const data = role.data();
        const groupRef = await data.group.get();
        const group = groupRef.data();
        const accountRef = await data.account.get();
        const account = accountRef.data();
        data.account.get();
        return {
            group,
            account,
            id: role.id,
            type: data.type,
        };
    }));
};
exports.addRole = async (data) => {
    await database_1.default.firestore().collection('role').add({
        type: 'USER',
        account: database_1.default.firestore().doc(`account/${data.accountId}`),
        group: database_1.default.firestore().doc(`group/${data.groupId}`)
    });
    return { message: 'role added' };
};
//# sourceMappingURL=index.js.map