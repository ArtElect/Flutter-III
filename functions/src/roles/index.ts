import {AddRoleData, ModifyRoleData} from './types';

import database from "../database";
import { getAccountFromUserId } from "../accounts";
import {getRightId} from "../rights";

export const listAccountRoles = async (userId: string) => {
  const account = await getAccountFromUserId(userId)
  const accountRef = await database.firestore().collection('account').doc(account!.id);
  const roles = await database.firestore()
    .collection('role')
    .where('accounts', 'array-contains', database.firestore().collection('account').doc(accountRef.id))
    .get();
  return Promise.all(roles.docs.map(async (role) => {
    const data = role.data();

    const groupRef = await data.group.get();
    const group = {
      id: groupRef.id,
      ...groupRef.data()
    };

    const rights = await Promise.all(data.rights.map(async (r: any) => {
      const rightRef = await r.get();
      return {
        id: rightRef.id,
        ...rightRef.data()
      };
    }));

    const accounts = await Promise.all(data.accounts.map(async (a: any) => {
      const aRef = await a.get();
      return aRef.data();
    }));

    return {
      group,
      rights,
      accounts,
      id: role.id,
      type: data.type,
      name: data.name,
    }
  }));
}

export const addRole = async (data: AddRoleData) => {
  const readRight = await database.firestore().collection('right').where('action', '==', 'READ').get();
  if (readRight.size !== 1) {
    throw new Error('Invalid rights');
  }
  const role = await database.firestore().collection('role').add({
    name: data.name,
    group: database.firestore().doc(`group/${data.groupId}`),
    rights: [database.firestore().collection('right').doc(readRight.docs[0].id)],
    accounts: [],
  })
  const rights = await Promise.all(data.rightsId.map(async (r) => database.firestore().collection('right').doc(r)));
  await Promise.all(rights.map(r => database.firestore().collection('role').doc(role.id).update({
    rights: database.firestore.FieldValue.arrayUnion(r),
  })));
  return { message: 'role added' };
}

export const assignRole = async (roleId: string, accountId: string) => {
  const role = database.firestore().collection('role').doc(roleId);
  const account = database.firestore().collection('account').doc(accountId);
  await database.firestore().collection('role').doc(role.id).update({
    accounts: database.firestore.FieldValue.arrayUnion(account),
  });
  return { message: 'user assigned to role' }
}

export const modifyRole = async (roleId: string, data: ModifyRoleData) => {
  const rights = await Promise.all(data.rightsId.map(async (r) => database.firestore().collection('right').doc(r)));
  const readRightId = await getRightId('READ');
  await database.firestore().collection('role').doc(roleId).update({ rights: [database.firestore().collection('right').doc(readRightId)] });
  await Promise.all(rights.map(r => database.firestore().collection('role').doc(roleId).update({
    rights: database.firestore.FieldValue.arrayUnion(r),
  })));
  return { message: 'role updated' };
}


export const deleteRole = async (roleId: string) => {
  await database.firestore().collection('role').doc(roleId).delete();
  return { message: 'role deleted' };
}

export const listRoles = async () => {
  const roles = await database.firestore()
    .collection('role')
    .get();
  return Promise.all(roles.docs.map(async (role) => {
    const data = role.data();

    const groupRef = await data.group.get();
    const group = {
      id: groupRef.id,
      ...groupRef.data()
    };

    const rights = await Promise.all(data.rights.map(async (r: any) => {
      const rightRef = await r.get();
      return {
        id: rightRef.id,
        ...rightRef.data()
      };
    }));

    const accounts = await Promise.all(data.accounts.map(async (a: any) => {
      const aRef = await a.get();
      return {
        id: aRef.id,
        ...aRef.data()
      };
    }));

    return {
      group,
      rights,
      accounts,
      id: role.id,
      type: data.type,
      name: data.name,
    }
  }));
}
