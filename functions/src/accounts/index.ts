import { v4 as uuidv4 } from 'uuid';

export const getAccount = async (firestore: any, accountId: string) => {
  return firestore.collection('account').doc(accountId);
};

export const getAccountFromUserId = async (firestore: any, userId: string) => {
  const accounts = await firestore.collection('account').where('userId', '==', userId).get();
  if (accounts._size === 0) {
    return undefined;
  }
  return {
    id: accounts.docs[0].id,
    ...accounts.docs[0].data()
  };
};

export const createAccount = async (firestore: any, userId: string) => {
  const data = {
    userId,
    pseudo: `user-${uuidv4()}`,
    image: 'https://cdn.iconscout.com/icon/free/png-256/avatar-370-456322.png',
  };
  return firestore.collection('account').add(data);
};
