"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteProject = exports.modifyProject = exports.addProject = exports.listAccountProjects = void 0;
const database_1 = require("../database");
const accounts_1 = require("../accounts");
const rights_1 = require("../rights");
exports.listAccountProjects = async (userId) => {
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
        const projectsDocs = await database_1.default.firestore().collection('project')
            .where('group', '==', data.group)
            .get();
        const projects = projectsDocs.docs.map((pd) => {
            return Object.assign({ id: pd.id }, pd.data());
        });
        return {
            group,
            account,
            projects,
            id: role.id,
            type: data.type,
        };
    }));
};
exports.addProject = async (groupId, userId, data) => {
    const account = await accounts_1.getAccountFromUserId(userId);
    const accountRef = database_1.default.firestore().collection('account').doc(account.id);
    const groupRef = database_1.default.firestore().doc(`group/${groupId}`);
    const createRightId = await rights_1.getRightId('CREATE');
    const canCreate = await database_1.default.firestore()
        .collection('role')
        .where('account', '==', accountRef)
        .where('group', '==', groupRef)
        .where('rights', 'array-contains', database_1.default.firestore().collection('right').doc(createRightId))
        .get();
    // @ts-ignore
    if (account.role !== 'ADMIN' && canCreate.size === 0) {
        throw new Error('Unauthorized');
    }
    await database_1.default.firestore().collection('project').add({
        title: data.title,
        description: data.description,
        group: groupRef
    });
    return { message: 'project created' };
};
exports.modifyProject = async (projectId, groupId, userId, data) => {
    const account = await accounts_1.getAccountFromUserId(userId);
    const accountRef = database_1.default.firestore().collection('account').doc(account.id);
    const groupRef = database_1.default.firestore().doc(`group/${groupId}`);
    const updateRightId = await rights_1.getRightId('UPDATE');
    const canUpdate = await database_1.default.firestore()
        .collection('role')
        .where('account', '==', accountRef)
        .where('group', '==', groupRef)
        .where('rights', 'array-contains', database_1.default.firestore().collection('right').doc(updateRightId))
        .get();
    // @ts-ignore
    if (account.role !== 'ADMIN' && canUpdate.size === 0) {
        throw new Error('Unauthorized');
    }
    await database_1.default.firestore().collection('project').doc(projectId).update(data);
    return { message: 'project updated' };
};
exports.deleteProject = async (projectId, groupId, userId) => {
    const account = await accounts_1.getAccountFromUserId(userId);
    const accountRef = database_1.default.firestore().collection('account').doc(account.id);
    const groupRef = database_1.default.firestore().doc(`group/${groupId}`);
    const deleteRightId = await rights_1.getRightId('DELETE');
    const canDelete = await database_1.default.firestore()
        .collection('role')
        .where('account', '==', accountRef)
        .where('group', '==', groupRef)
        .where('rights', 'array-contains', database_1.default.firestore().collection('right').doc(deleteRightId))
        .get();
    // @ts-ignore
    if (account.role !== 'ADMIN' && canDelete.size === 0) {
        throw new Error('Unauthorized');
    }
    await database_1.default.firestore().collection('project').doc(projectId).delete();
    return { message: 'project deleted' };
};
//# sourceMappingURL=index.js.map