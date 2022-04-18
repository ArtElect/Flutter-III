import { AddGroupData } from './types';

import database from "../database";

export const getGroup = async (account: any) => {
  const groups = await database.firestore().collection('group').get();
  const groupsData = groups.docs.map((group: any) => {
    return {
      id: group.id,
      ...group.data()
    };
  });
  if (account.role === 'ADMIN') {
    return groupsData;
  }
  return groupsData.filter((group: any) => group.members.find((member: any) => member.id === account.id));
};

export const addGroup = async (data: AddGroupData) => {
  await database.firestore().collection('group').add(data);
  return { message: 'group created' };
};
