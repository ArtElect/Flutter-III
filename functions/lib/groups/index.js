"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.addGroup = exports.getGroup = void 0;
const database_1 = require("../database");
exports.getGroup = async (account) => {
    const groups = await database_1.default.firestore().collection('group').get();
    const groupsData = groups.docs.map((group) => {
        return Object.assign({ id: group.id }, group.data());
    });
    if (account.role === 'ADMIN') {
        return groupsData;
    }
    return groupsData.filter((group) => group.members.find((member) => member.id === account.id));
};
exports.addGroup = async (data) => {
    await database_1.default.firestore().collection('group').add(data);
    return { message: 'group created' };
};
//# sourceMappingURL=index.js.map