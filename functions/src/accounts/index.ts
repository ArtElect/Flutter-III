import { CreateAccountData } from "./types";

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

export const createAccount = async (data: CreateAccountData) => {
  await database.firestore().collection('account').add({
    ...data,
    role: 'USER',
  });
  return { message: 'account created' };
};
