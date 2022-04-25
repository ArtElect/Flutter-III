// Follow instructions to set up admin credentials:
// https://firebase.google.com/docs/functions/local-emulator#set_up_admin_credentials_optional
import * as cors from 'cors';
import * as express from 'express';
import * as bodyParser from 'body-parser';
import * as functions from 'firebase-functions';

import {createAccount, getAccountFromUserId, updateAccount} from './accounts';

import database from './database';
import { listPossibleRights } from "./rights";
import { AddRoleData, ModifyRoleData } from "./roles/types";
import {addGroup, deleteGroup, getGroup, modifyGroup} from './groups';
import { AddGroupData, ModifyGroupData } from './groups/types';
import {addRole, deleteRole, listAccountRoles, modifyRole} from "./roles";
import { AddProjectData, ModifyProjectData } from "./projects/types";
import { addProject, listAccountProjects, modifyProject, deleteProject } from "./projects";

import { validationMiddleware } from './middlewares';
import {ModifyAccountData} from "./accounts/types";

const app = express();

app.use(cors());
app.use(bodyParser.json());

// Express middleware that validates Firebase ID Tokens
// passed in the Authorization HTTP header.
// The Firebase ID token needs to be passed as a Bearer
// token in the Authorization HTTP header like this:
// `Authorization: Bearer <Firebase ID Token>`.
// when decoded successfully, the ID Token content will be added as `req.user`.
const userMiddleware = async (
  req: any,
  res: any,
  next: any) => {
  if (!req.headers.authorization ||
    !req.headers.authorization.startsWith('Bearer ')) {
    res.status(401).send('Unauthorized');
    return;
  }
  const idToken = req.headers.authorization.split('Bearer ')[1];
  try {
    res.locals.user = await database.auth().verifyIdToken(idToken);
    next();
    return;
  } catch (e) {
    res.status(401).send('Unauthorized');
    return;
  }
};

const adminMiddleware = async (
  req: any,
  res: any,
  next: any) => {
  try {
    const account = await getAccountFromUserId(res.locals.user.uid);
    // @ts-ignore
    if (account!.role !== 'ADMIN') {
      res.status(401).send('Unauthorized');
      return;
    }
    next();
    return;
  } catch (e) {
    res.status(401).send('Unauthorized');
    return;
  }
};

// PING

app.get('/ping', async (req, res, _next) => {
  res.send({ message: 'pong' });
});

// AUTH MIDDLEWARE

app.use(userMiddleware);

// USERS

app.get('/account', async (req, res, _next) => {
  res.send(await getAccountFromUserId(res.locals.user.uid));
});

app.post('/account', async (req, res, _next) => {
  const existAccount = await getAccountFromUserId(res.locals.user.uid);
  if (existAccount) {
    res.send(existAccount);
  } else {
    const account = await createAccount({ userId: res.locals.user.uid });
    res.send(account);
  }
});

app.patch('/account', validationMiddleware(ModifyAccountData, 'body'), async (req, res, _next) => {
  res.send(await updateAccount(res.locals.user.uid, req.body));
});

// GROUPS

app.get('/groups', async (req, res, _next) => {
  const account = await getAccountFromUserId(res.locals.user.uid);
  res.send(await getGroup(account));
});

app.post('/groups', adminMiddleware, validationMiddleware(AddGroupData, 'body'), async (req, res, _next) => {
  res.send(await addGroup(req.body));
});

app.patch('/groups/:groupId', adminMiddleware, validationMiddleware(ModifyGroupData, 'body'), async (req, res, _next) => {
  res.send(await modifyGroup(req.params.groupId, req.body));
});

app.delete('/groups/:groupId', adminMiddleware, async (req, res, _next) => {
  res.send(await deleteGroup(req.params.groupId));
});

// RIGHTS
app.get('/rights', async (req, res, _next) => {
  res.send(await listPossibleRights());
});

// ROLES

app.get('/roles', async (req, res, _next) => {
  res.send(await listAccountRoles(res.locals.user.uid));
});

app.post('/roles', adminMiddleware, validationMiddleware(AddRoleData, 'body'), async (req, res, _next) => {
  res.send(await addRole(req.body));
});

app.patch('/roles/:roleId', adminMiddleware, validationMiddleware(ModifyRoleData, 'body'), async (req, res, _next) => {
  res.send(await modifyRole(req.params.roleId, req.body));
});

app.delete('/roles/:roleId', adminMiddleware, async (req, res, _next) => {
  res.send(await deleteRole(req.params.roleId));
});

// PROJECTS

app.get('/projects', async (req, res, _next) => {
  res.send(await listAccountProjects(res.locals.user.uid));
});

app.post('/groups/:groupId/projects', validationMiddleware(AddProjectData, 'body'), async (req, res, _next) => {
  res.send(await addProject(req.params.groupId, res.locals.user.uid, req.body));
});

app.patch('/groups/:groupId/projects/:projectId', validationMiddleware(ModifyProjectData, 'body'), async (req, res, _next) => {
  res.send(await modifyProject(req.params.projectId, req.params.groupId, res.locals.user.uid, req.body));
});

app.delete('/groups/:groupId/projects/:projectId', async (req, res, _next) => {
  res.send(await deleteProject(req.params.projectId, req.params.groupId, res.locals.user.uid));
});

/*
app.put('/posts/:id/like', async (req, res, _next) => {
  const account = await getAccountFromUserId(admin.firestore(), res.locals.user.uid);
  res.send(await likePost(admin.firestore(), admin.firestore.FieldValue.increment(1), admin.firestore.FieldValue.arrayUnion, req.params.id, account));
});
 */

exports.api = functions.https.onRequest(app);
