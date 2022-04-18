"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.addProject = exports.listAccountProjects = void 0;
const database_1 = require("../database");
const accounts_1 = require("../accounts");
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
exports.addProject = async (userId, data) => {
    const account = await accounts_1.getAccountFromUserId(userId);
    const accountRef = await database_1.default.firestore().collection('account').doc(account.id);
    const groupRef = await database_1.default.firestore().doc(`group/${data.groupId}`);
    const canEdit = await database_1.default.firestore()
        .collection('role')
        .where('account', '==', accountRef)
        .where('group', '==', groupRef)
        .where('type', '==', 'MANAGER')
        .get();
    if (canEdit.size === 0) {
        throw new Error('Unauthorized');
    }
    await database_1.default.firestore().collection('project').add({
        title: data.title,
        description: data.description,
        group: groupRef
    });
    return { message: 'project created' };
};
//# sourceMappingURL=index.js.map