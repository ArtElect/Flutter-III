"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.listRoles = exports.deleteRole = exports.modifyRole = exports.assignRole = exports.addRole = exports.listAccountRoles = void 0;
const database_1 = require("../database");
const accounts_1 = require("../accounts");
const rights_1 = require("../rights");
exports.listAccountRoles = async (userId) => {
    const account = await accounts_1.getAccountFromUserId(userId);
    const accountRef = await database_1.default.firestore().collection('account').doc(account.id);
    const roles = await database_1.default.firestore()
        .collection('role')
        .where('accounts', 'array-contains', database_1.default.firestore().collection('account').doc(accountRef.id))
        .get();
    return Promise.all(roles.docs.map(async (role) => {
        const data = role.data();
        const groupRef = await data.group.get();
        const group = Object.assign({ id: groupRef.id }, groupRef.data());
        const rights = await Promise.all(data.rights.map(async (r) => {
            const rightRef = await r.get();
            return Object.assign({ id: rightRef.id }, rightRef.data());
        }));
        const accounts = await Promise.all(data.accounts.map(async (a) => {
            const aRef = await a.get();
            return aRef.data();
        }));
        return {
            group,
            rights,
            accounts,
            id: role.id,
            type: data.type,
            name: data.name,
        };
    }));
};
exports.addRole = async (data) => {
    const readRight = await database_1.default.firestore().collection('right').where('action', '==', 'READ').get();
    if (readRight.size !== 1) {
        throw new Error('Invalid rights');
    }
    const role = await database_1.default.firestore().collection('role').add({
        name: data.name,
        group: database_1.default.firestore().doc(`group/${data.groupId}`),
        rights: [database_1.default.firestore().collection('right').doc(readRight.docs[0].id)],
        accounts: [],
    });
    const rights = await Promise.all(data.rightsId.map(async (r) => database_1.default.firestore().collection('right').doc(r)));
    await Promise.all(rights.map(r => database_1.default.firestore().collection('role').doc(role.id).update({
        rights: database_1.default.firestore.FieldValue.arrayUnion(r),
    })));
    return { message: 'role added' };
};
exports.assignRole = async (roleId, accountId) => {
    const role = database_1.default.firestore().collection('role').doc(roleId);
    const account = database_1.default.firestore().collection('account').doc(accountId);
    await database_1.default.firestore().collection('role').doc(role.id).update({
        accounts: database_1.default.firestore.FieldValue.arrayUnion(account),
    });
    return { message: 'user assigned to role' };
};
exports.modifyRole = async (roleId, data) => {
    const rights = await Promise.all(data.rightsId.map(async (r) => database_1.default.firestore().collection('right').doc(r)));
    const readRightId = await rights_1.getRightId('READ');
    await database_1.default.firestore().collection('role').doc(roleId).update({ rights: [database_1.default.firestore().collection('right').doc(readRightId)] });
    await Promise.all(rights.map(r => database_1.default.firestore().collection('role').doc(roleId).update({
        rights: database_1.default.firestore.FieldValue.arrayUnion(r),
    })));
    return { message: 'role updated' };
};
exports.deleteRole = async (roleId) => {
    await database_1.default.firestore().collection('role').doc(roleId).delete();
    return { message: 'role deleted' };
};
exports.listRoles = async () => {
    const roles = await database_1.default.firestore()
        .collection('role')
        .get();
    return Promise.all(roles.docs.map(async (role) => {
        const data = role.data();
        const groupRef = await data.group.get();
        const group = Object.assign({ id: groupRef.id }, groupRef.data());
        const rights = await Promise.all(data.rights.map(async (r) => {
            const rightRef = await r.get();
            return Object.assign({ id: rightRef.id }, rightRef.data());
        }));
        const accounts = await Promise.all(data.accounts.map(async (a) => {
            const aRef = await a.get();
            return Object.assign({ id: aRef.id }, aRef.data());
        }));
        return {
            group,
            rights,
            accounts,
            id: role.id,
            type: data.type,
            name: data.name,
        };
    }));
};
//# sourceMappingURL=index.js.map