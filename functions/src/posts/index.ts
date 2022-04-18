import { AddPostData } from './types';

export const getPosts = async (firestore: any) => {
  const posts = await firestore.collection('post').get();
  return posts.docs.map((post: any) => {
    console.log(post);
    return {
      id: post.id,
      ...post.data()
    };
  });
};

export const getPostsFromAccountId = async (firestore: any, accountId: string) => {
  const posts = await firestore.collection('post').get();
  const accountPosts = posts.docs.filter((post: any) => post.data().accountId === accountId);
  return accountPosts.docs.map((post: any) => post.data());
};

export const addPost = async (firestore: any, data: AddPostData, account: any) => {
  return firestore.collection('post').add({
    ...data,
    account: firestore.doc(`account/${account.id}`),
  });
};

export const likePost = async (firestore: any, incr: any, union: any, postId: string, account: any) => {
  const like = await firestore.collection('like').add({
    image: account.image,
    pseudo: account.pseudo,
    account: firestore.doc(`account/${account.id}`),
  });
  return firestore.collection('post').doc(postId).update({ numberOfLike: incr, likes: union(like) });
};
