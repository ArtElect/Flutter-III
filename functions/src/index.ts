// Follow instructions to set up admin credentials:
// https://firebase.google.com/docs/functions/local-emulator#set_up_admin_credentials_optional
import * as cors from 'cors';
import * as express from 'express';
import * as admin from 'firebase-admin';
import * as bodyParser from 'body-parser';
import * as functions from 'firebase-functions';

import { createAccount, getAccountFromUserId } from './accounts';

import { AddPostData } from './posts/types';
import { getPosts, addPost, likePost } from './posts';

import { validationMiddleware } from './middlewares';

const databaseURL = 'https://flutter-iii-8a868-default-rtdb.europe-west1.firebasedatabase.app';

admin.initializeApp({
  databaseURL,
  credential: admin.credential.applicationDefault(),
});

const app = express();

app.use(cors());
app.use(bodyParser.json());

// Express middleware that validates Firebase ID Tokens
// passed in the Authorization HTTP header.
// The Firebase ID token needs to be passed as a Bearer
// token in the Authorization HTTP header like this:
// `Authorization: Bearer <Firebase ID Token>`.
// when decoded successfully, the ID Token content will be added as `req.user`.
const authenticate = async (
  req: any,
  res: any,
  next: any) => {
  if (!req.headers.authorization ||
    !req.headers.authorization.startsWith('Bearer ')) {
    res.status(403).send('Unauthorized');
    return;
  }
  const idToken = req.headers.authorization.split('Bearer ')[1];
  try {
    const decodedIdToken = await admin.auth().verifyIdToken(idToken);
    res.locals.user = decodedIdToken;
    next();
    return;
  } catch (e) {
    res.status(403).send('Unauthorized');
    return;
  }
};


// PING

app.get('/ping', async (req, res, _next) => {
  res.send({ message: 'pong' });
});

// AUTH

app.use(authenticate);

// USERS

app.get('/account', async (req, res, _next) => {
  res.send(await getAccountFromUserId(admin.firestore(), res.locals.user.uid));
});

app.post('/account', async (req, res, _next) => {
  const existAccount = await getAccountFromUserId(admin.firestore(), res.locals.user.uid);
  if (existAccount) {
    res.send(existAccount);
  } else {
    const account = await createAccount(admin.firestore(), res.locals.user.uid);
    res.send(account);
  }
});

// POSTS

app.get('/posts', async (req, res, _next) => {
  res.send(await getPosts(admin.firestore()));
});

app.post('/posts', validationMiddleware(AddPostData, 'body'), async (req, res, _next) => {
  const account = await getAccountFromUserId(admin.firestore(), res.locals.user.uid);
  res.send(await addPost(admin.firestore(), req.body, account));
});

app.put('/posts/:id/like', async (req, res, _next) => {
  const account = await getAccountFromUserId(admin.firestore(), res.locals.user.uid);
  res.send(await likePost(admin.firestore(), admin.firestore.FieldValue.increment(1), admin.firestore.FieldValue.arrayUnion, req.params.id, account));
});

exports.api = functions.https.onRequest(app);
