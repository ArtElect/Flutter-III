"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.likePost = exports.addPost = exports.getPostsFromAccountId = exports.getPosts = void 0;
exports.getPosts = async (firestore) => {
    const posts = await firestore.collection('post').get();
    return posts.docs.map((post) => {
        console.log(post);
        return Object.assign({ id: post.id }, post.data());
    });
};
exports.getPostsFromAccountId = async (firestore, accountId) => {
    const posts = await firestore.collection('post').get();
    const accountPosts = posts.docs.filter((post) => post.data().accountId === accountId);
    return accountPosts.docs.map((post) => post.data());
};
exports.addPost = async (firestore, data, account) => {
    return firestore.collection('post').add(Object.assign(Object.assign({}, data), { account: firestore.doc(`account/${account.id}`) }));
};
exports.likePost = async (firestore, incr, union, postId, account) => {
    const like = await firestore.collection('like').add({
        image: account.image,
        pseudo: account.pseudo,
        account: firestore.doc(`account/${account.id}`),
    });
    return firestore.collection('post').doc(postId).update({ numberOfLike: incr, likes: union(like) });
};
//# sourceMappingURL=index.js.map