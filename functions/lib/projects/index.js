"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.listGroupProjects = exports.deleteProject = exports.modifyProject = exports.addProject = exports.listAccountProjects = void 0;
const database_1 = require("../database");
const accounts_1 = require("../accounts");
const rights_1 = require("../rights");
exports.listAccountProjects = async (userId) => {
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
        const projectsDocs = await database_1.default.firestore().collection('project')
            .where('group', '==', data.group)
            .get();
        const projects = projectsDocs.docs.map((pd) => {
            return Object.assign({ id: pd.id }, pd.data());
        });
        return {
            group,
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
    const roles = await database_1.default.firestore()
        .collection('role')
        .where('accounts', 'array-contains', database_1.default.firestore().collection('account').doc(accountRef.id))
        .where('group', '==', groupRef)
        .get();
    const canCreate = (await Promise.all(roles.docs.map(async (r) => {
        const data = r.data();
        const rights = await Promise.all(data.rights.map(async (r) => {
            const d = await r.get();
            return Object.assign({ id: d.id }, d.data());
        }));
        return rights.filter((d) => d.id === createRightId);
    }))).flat();
    // @ts-ignore
    if (account.role !== 'ADMIN' && canCreate.length === 0) {
        throw new Error('Unauthorized');
    }
    await database_1.default.firestore().collection('project').add({
        title: data.title,
        description: data.description,
        image: data.image,
        group: groupRef
    });
    return { message: 'project created' };
};
exports.modifyProject = async (projectId, groupId, userId, data) => {
    const account = await accounts_1.getAccountFromUserId(userId);
    const accountRef = database_1.default.firestore().collection('account').doc(account.id);
    const groupRef = database_1.default.firestore().doc(`group/${groupId}`);
    const updateRightId = await rights_1.getRightId('UPDATE');
    let roles = await database_1.default.firestore()
        .collection('role')
        .where('accounts', 'array-contains', database_1.default.firestore().collection('account').doc(accountRef.id))
        .where('group', '==', groupRef)
        .get();
    const canUpdate = (await Promise.all(roles.docs.map(async (r) => {
        const data = r.data();
        const rights = await Promise.all(data.rights.map(async (r) => {
            const d = await r.get();
            return Object.assign({ id: d.id }, d.data());
        }));
        return rights.filter((d) => d.id === updateRightId);
    }))).flat();
    // @ts-ignore
    if (account.role !== 'ADMIN' && canUpdate.length === 0) {
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
    const roles = await database_1.default.firestore()
        .collection('role')
        .where('accounts', 'array-contains', database_1.default.firestore().collection('account').doc(accountRef.id))
        .where('group', '==', groupRef)
        .get();
    const canDelete = (await Promise.all(roles.docs.map(async (r) => {
        const data = r.data();
        const rights = await Promise.all(data.rights.map(async (r) => {
            const d = await r.get();
            return Object.assign({ id: d.id }, d.data());
        }));
        return rights.filter((d) => d.id === deleteRightId);
    }))).flat();
    // @ts-ignore
    if (account.role !== 'ADMIN' && canDelete.length === 0) {
        throw new Error('Unauthorized');
    }
    await database_1.default.firestore().collection('project').doc(projectId).delete();
    return { message: 'project deleted' };
};
exports.listGroupProjects = async (userId, groupId) => {
    const account = await accounts_1.getAccountFromUserId(userId);
    const accountRef = await database_1.default.firestore().collection('account').doc(account.id);
    const groupRef = await database_1.default.firestore().collection('group').doc(groupId);
    const roles = await database_1.default.firestore()
        .collection('role')
        .where('accounts', 'array-contains', database_1.default.firestore().collection('account').doc(accountRef.id))
        .where('group', '==', groupRef)
        .get();
    return Promise.all(roles.docs.map(async (role) => {
        const data = role.data();
        const groupRef = await data.group.get();
        const group = Object.assign({ id: groupRef.id }, groupRef.data());
        const projectsDocs = await database_1.default.firestore().collection('project')
            .where('group', '==', data.group)
            .get();
        const projects = projectsDocs.docs.map((pd) => {
            return Object.assign({ id: pd.id }, pd.data());
        });
        return {
            group,
            projects,
            id: role.id,
            type: data.type,
        };
    }));
};
//# sourceMappingURL=index.js.map