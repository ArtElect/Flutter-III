import { AddGroupData } from './types';

import database from "../database";

export const getGroup = async (account: any) => {
  const groups = await database.firestore().collection('group').get();
  const groupsData = await Promise.all(groups.docs.map(async (group: any) => {
    const data = group.data();

    const projects = await database.firestore().collection('project')
      .where('group', '==', database.firestore().collection('group').doc(group.id))
      .get();

    return {
      ...data,
      projects: projects.docs.map((p) => {
        return {
          id: p.id,
          ...p.data()
        }
      }),
      id: group.id,
    };
  }));
  if (account.role === 'ADMIN') {
    return groupsData;
  }
  return groupsData.filter((group: any) => group.members.find((member: any) => member.id === account.id));
};

export const addGroup = async (data: AddGroupData) => {
  await database.firestore().collection('group').add(data);
  return { message: 'group created' };
};

export const modifyGroup = async (groupId: string, data: AddGroupData) => {
  await database.firestore().collection('group').doc(groupId).update(data);
  return { message: 'group updated' };
};

export const deleteGroup = async (groupId: string) => {
  await database.firestore().collection('group').doc(groupId).delete();
  return { message: 'group deleted' };
}
