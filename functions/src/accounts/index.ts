import {CreateAccountData, ModifyAccountData} from "./types";

import database from "../database";

export const getAccountFromUserId = async (userId: string) => {
  const accounts = await database.firestore().collection('account').where('userId', '==', userId).get();
  if (accounts.size === 0) {
    return undefined;
  }
  return {
    id: accounts.docs[0].id,
    ...accounts.docs[0].data()
  };
};

export const createAccount = async (data: CreateAccountData, role: string) => {
  await database.firestore().collection('account').add({
    ...data,
    image: '',
    role,
  });
  return { message: 'account created' };
};

export const updateAccount = async (userId: string, data: ModifyAccountData) => {
  const accounts = await database.firestore().collection('account').where('userId', '==', userId).get();
  if (accounts.size === 0) {
    return undefined;
  }
  await database.firestore().collection('account').doc(accounts.docs[0].id).update(data);
  return { message: 'account updated' };
}

export const getAccounts = async () => {
  const accounts = await database.firestore().collection('account').get();
  return accounts.docs.map((account: any) => {
    return {
      id: account.id,
      ...account.data()
    };
  });
};
