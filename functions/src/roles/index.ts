import { AddRoleData } from './types';

import database from "../database";
import { getAccountFromUserId } from "../accounts";

export const listAccountRoles = async (userId: string) => {
  const account = await getAccountFromUserId(userId)
  const accountRef = await database.firestore().collection('account').doc(account!.id);
  const roles = await database.firestore()
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
    }
  }));
}

export const addRole = async (data: AddRoleData) => {
  await database.firestore().collection('role').add({
    type: 'USER',
    account: database.firestore().doc(`account/${data.accountId}`),
    group: database.firestore().doc(`group/${data.groupId}`)
  })
  return { message: 'role added' };
}
