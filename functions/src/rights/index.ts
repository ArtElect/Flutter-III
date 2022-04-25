import database from "../database";

export const listPossibleRights = async () => {
  const rights = await database.firestore().collection('right').get();
  return rights.docs.map((right: any) => {
    return {
      id: right.id,
      ...right.data()
    };
  });
}

export const getRightId = async (right: string) => {
  const rights = await database.firestore().collection('right').where('action', '==', right).get();
  if (rights.size !== 1) {
    throw new Error('Invalid right');
  }
  return rights.docs[0].id;
}
