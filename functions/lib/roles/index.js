"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.listRoles = exports.deleteRole = exports.modifyRole = exports.addRole = exports.listAccountRoles = void 0;
const database_1 = require("../database");
const accounts_1 = require("../accounts");
const rights_1 = require("../rights");
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
        const rights = await Promise.all(data.rights.map(async (r) => {
            const rightRef = await r.get();
            return rightRef.data();
        }));
        return {
            group,
            rights,
            account,
            id: role.id,
            type: data.type,
        };
    }));
};
exports.addRole = async (data) => {
    const readRight = await database_1.default.firestore().collection('right').where('action', '==', 'READ').get();
    if (readRight.size !== 1) {
        throw new Error('Invalid rights');
    }
    await database_1.default.firestore().collection('role').add({
        rights: [database_1.default.firestore().collection('right').doc(readRight.docs[0].id)],
        account: database_1.default.firestore().doc(`account/${data.accountId}`),
        group: database_1.default.firestore().doc(`group/${data.groupId}`)
    });
    return { message: 'role added' };
};
exports.modifyRole = async (roleId, data) => {
    const rights = await Promise.all(data.rightsId.map(async (r) => database_1.default.firestore().collection('right').doc(r)));
    const readRightId = await rights_1.getRightId('READ');
    await database_1.default.firestore().collection('role').doc(roleId).set({ rights: [database_1.default.firestore().collection('right').doc(readRightId)] }, { merge: true });
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
        const group = groupRef.data();
        const accountRef = await data.account.get();
        const account = accountRef.data();
        const rights = await Promise.all(data.rights.map(async (r) => {
            const rightRef = await r.get();
            return rightRef.data();
        }));
        return {
            group,
            rights,
            account,
            id: role.id,
            type: data.type,
        };
    }));
};
//# sourceMappingURL=index.js.map