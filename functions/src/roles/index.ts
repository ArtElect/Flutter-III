import {AddRoleData, ModifyRoleData} from './types';

import database from "../database";
import { getAccountFromUserId } from "../accounts";
import {getRightId} from "../rights";

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

    const rights = await Promise.all(data.rights.map(async (r: any) => {
      const rightRef = await r.get();
      return rightRef.data();
    }));

    return {
      group,
      rights,
      account,
      id: role.id,
      type: data.type,
    }
  }));
}

export const addRole = async (data: AddRoleData) => {
  const readRight = await database.firestore().collection('right').where('action', '==', 'READ').get();
  if (readRight.size !== 1) {
    throw new Error('Invalid rights');
  }
  await database.firestore().collection('role').add({
    rights: [database.firestore().collection('right').doc(readRight.docs[0].id)],
    account: database.firestore().doc(`account/${data.accountId}`),
    group: database.firestore().doc(`group/${data.groupId}`)
  })
  return { message: 'role added' };
}

export const modifyRole = async (roleId: string, data: ModifyRoleData) => {
  const rights = await Promise.all(data.rightsId.map(async (r) => database.firestore().collection('right').doc(r)));
  const readRightId = await getRightId('READ');
  await database.firestore().collection('role').doc(roleId).set({ rights: [database.firestore().collection('right').doc(readRightId)] }, { merge: true });
  await Promise.all(rights.map(r => database.firestore().collection('role').doc(roleId).update({
    rights: database.firestore.FieldValue.arrayUnion(r),
  })));
  return { message: 'role updated' };
}


export const deleteRole = async (roleId: string) => {
  await database.firestore().collection('role').doc(roleId).delete();
  return { message: 'role deleted' };
}
