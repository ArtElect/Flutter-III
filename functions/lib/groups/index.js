"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteGroup = exports.modifyGroup = exports.addGroup = exports.getGroup = void 0;
const database_1 = require("../database");
exports.getGroup = async (account) => {
    const groups = await database_1.default.firestore().collection('group').get();
    const groupsData = await Promise.all(groups.docs.map(async (group) => {
        const data = group.data();
        const projects = await database_1.default.firestore().collection('project')
            .where('group', '==', database_1.default.firestore().collection('group').doc(group.id))
            .get();
        return Object.assign(Object.assign({}, data), { projects: projects.docs.map((p) => {
                return Object.assign({ id: p.id }, p.data());
            }), id: group.id });
    }));
    if (account.role === 'ADMIN') {
        return groupsData;
    }
    return groupsData.filter((group) => group.members.find((member) => member.id === account.id));
};
exports.addGroup = async (data) => {
    await database_1.default.firestore().collection('group').add(data);
    return { message: 'group created' };
};
exports.modifyGroup = async (groupId, data) => {
    await database_1.default.firestore().collection('group').doc(groupId).update(data);
    return { message: 'group updated' };
};
exports.deleteGroup = async (groupId) => {
    await database_1.default.firestore().collection('group').doc(groupId).delete();
    return { message: 'group deleted' };
};
//# sourceMappingURL=index.js.map