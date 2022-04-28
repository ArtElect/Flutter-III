import { AddProjectData } from './types';

import database from "../database";
import { getAccountFromUserId } from "../accounts";
import { getRightId } from "../rights";

export const listAccountProjects = async (userId: string) => {
  const account = await getAccountFromUserId(userId)
  const accountRef = await database.firestore().collection('account').doc(account!.id);
  const roles = await database.firestore()
    .collection('role')
    .where('accounts', 'array-contains', database.firestore().collection('account').doc(accountRef.id))
    .get();
  return Promise.all(roles.docs.map(async (role) => {
    const data = role.data();

    const groupRef = await data.group.get();
    const group = groupRef.data();

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

  const roles = await database.firestore()
    .collection('role')
    .where('accounts', 'array-contains', database.firestore().collection('account').doc(accountRef.id))
    .where('group', '==', groupRef)
    .get()
  const canCreate = (await Promise.all(roles.docs.map(async (r) => {
    const data = r.data();
    const rights = await Promise.all(data.rights.map(async (r: any) => {
      const d = await r.get();
      return {
        id: d.id,
        ...d.data()
      }})
    );
    return rights.filter((d: any) => d.id === createRightId);
  }))).flat();
  // @ts-ignore
  if (account.role !== 'ADMIN' && canCreate.length === 0) {
    throw new Error('Unauthorized');
  }
  await database.firestore().collection('project').add({
    title: data.title,
    description: data.description,
    image: data.image,
    group: groupRef
  })
  return { message: 'project created' };
}

export const modifyProject = async (projectId: string, groupId: string, userId: string, data: AddProjectData) => {
  const account = await getAccountFromUserId(userId)
  const accountRef = database.firestore().collection('account').doc(account!.id);
  const groupRef = database.firestore().doc(`group/${groupId}`);
  const updateRightId = await getRightId('UPDATE');

  let roles = await database.firestore()
    .collection('role')
    .where('accounts', 'array-contains', database.firestore().collection('account').doc(accountRef.id))
    .where('group', '==', groupRef)
    .get()
  const canUpdate = (await Promise.all(roles.docs.map(async (r) => {
    const data = r.data();
    const rights = await Promise.all(data.rights.map(async (r: any) => {
      const d = await r.get();
      return {
        id: d.id,
        ...d.data()
      }})
    );
    return rights.filter((d: any) => d.id === updateRightId);
  }))).flat();
  // @ts-ignore
  if (account!.role !== 'ADMIN' && canUpdate.length === 0) {
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

  const roles = await database.firestore()
    .collection('role')
    .where('accounts', 'array-contains', database.firestore().collection('account').doc(accountRef.id))
    .where('group', '==', groupRef)
    .get()
  const canDelete = (await Promise.all(roles.docs.map(async (r) => {
    const data = r.data();
    const rights = await Promise.all(data.rights.map(async (r: any) => {
      const d = await r.get();
      return {
        id: d.id,
        ...d.data()
      }})
    );
    return rights.filter((d: any) => d.id === deleteRightId);
  }))).flat();
  // @ts-ignore
  if (account!.role !== 'ADMIN' && canDelete.length === 0) {
    throw new Error('Unauthorized');
  }
  await database.firestore().collection('project').doc(projectId).delete();
  return { message: 'project deleted' };
}

export const listGroupProjects = async (userId: string, groupId: string) => {
  const account = await getAccountFromUserId(userId)
  const accountRef = await database.firestore().collection('account').doc(account!.id);
  const groupRef = await database.firestore().collection('group').doc(groupId);
  const roles = await database.firestore()
    .collection('role')
    .where('accounts', 'array-contains', database.firestore().collection('account').doc(accountRef.id))
    .where('group', '==', groupRef)
    .get();
  return Promise.all(roles.docs.map(async (role) => {
    const data = role.data();

    const groupRef = await data.group.get();
    const group = groupRef.data();

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
      projects,
      id: role.id,
      type: data.type,
    }
  }));
}
