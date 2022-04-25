import { AddProjectData } from './types';

import database from "../database";
import { getAccountFromUserId } from "../accounts";
import { getRightId } from "../rights";

export const listAccountProjects = async (userId: string) => {
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

    const projectsDocs = await database.firestore().collection('project')
      .where('group', '==', data.group)
      .get();

    const projects = projectsDocs.docs.map((pd) => {
      return {
        id: pd.id,
        ...pd.data(),
      }
    })
    return {
      group,
      account,
      projects,
      id: role.id,
      type: data.type,
    }
  }));
}

export const addProject = async (groupId: string, userId: string, data: AddProjectData) => {
  const account = await getAccountFromUserId(userId)
  const accountRef = database.firestore().collection('account').doc(account!.id);
  const groupRef = database.firestore().doc(`group/${groupId}`);
  const createRightId = await getRightId('CREATE');

  const canCreate = await database.firestore()
    .collection('role')
    .where('account', '==', accountRef)
    .where('group', '==', groupRef)
    .where('rights', 'array-contains', database.firestore().collection('right').doc(createRightId))
    .get()
  // @ts-ignore
  if (account!.role !== 'ADMIN' && canCreate.size === 0) {
    throw new Error('Unauthorized');
  }
  await database.firestore().collection('project').add({
    title: data.title,
    description: data.description,
    group: groupRef
  })
  return { message: 'project created' };
}

export const modifyProject = async (projectId: string, groupId: string, userId: string, data: AddProjectData) => {
  const account = await getAccountFromUserId(userId)
  const accountRef = database.firestore().collection('account').doc(account!.id);
  const groupRef = database.firestore().doc(`group/${groupId}`);
  const updateRightId = await getRightId('UPDATE');

  const canUpdate = await database.firestore()
    .collection('role')
    .where('account', '==', accountRef)
    .where('group', '==', groupRef)
    .where('rights', 'array-contains', database.firestore().collection('right').doc(updateRightId))
    .get()
  // @ts-ignore
  if (account!.role !== 'ADMIN' && canUpdate.size === 0) {
    throw new Error('Unauthorized');
  }
  await database.firestore().collection('project').doc(projectId).update(data);
  return { message: 'project updated' };
}

export const deleteProject = async (projectId: string, groupId: string, userId: string) => {
  const account = await getAccountFromUserId(userId)
  const accountRef = database.firestore().collection('account').doc(account!.id);
  const groupRef = database.firestore().doc(`group/${groupId}`);
  const deleteRightId = await getRightId('DELETE');

  const canDelete = await database.firestore()
    .collection('role')
    .where('account', '==', accountRef)
    .where('group', '==', groupRef)
    .where('rights', 'array-contains', database.firestore().collection('right').doc(deleteRightId))
    .get()
  // @ts-ignore
  if (account!.role !== 'ADMIN' && canDelete.size === 0) {
    throw new Error('Unauthorized');
  }
  await database.firestore().collection('project').doc(projectId).delete();
  return { message: 'project deleted' };
}
