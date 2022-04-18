"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// Follow instructions to set up admin credentials:
// https://firebase.google.com/docs/functions/local-emulator#set_up_admin_credentials_optional
const cors = require("cors");
const express = require("express");
const bodyParser = require("body-parser");
const functions = require("firebase-functions");
const accounts_1 = require("./accounts");
const database_1 = require("./database");
const types_1 = require("./groups/types");
const groups_1 = require("./groups");
const types_2 = require("./roles/types");
const roles_1 = require("./roles");
const projects_1 = require("./projects");
const middlewares_1 = require("./middlewares");
const types_3 = require("./projects/types");
const app = express();
app.use(cors());
app.use(bodyParser.json());
// Express middleware that validates Firebase ID Tokens
// passed in the Authorization HTTP header.
// The Firebase ID token needs to be passed as a Bearer
// token in the Authorization HTTP header like this:
// `Authorization: Bearer <Firebase ID Token>`.
// when decoded successfully, the ID Token content will be added as `req.user`.
const userMiddleware = async (req, res, next) => {
    if (!req.headers.authorization ||
        !req.headers.authorization.startsWith('Bearer ')) {
        res.status(401).send('Unauthorized');
        return;
    }
    const idToken = req.headers.authorization.split('Bearer ')[1];
    try {
        res.locals.user = await database_1.default.auth().verifyIdToken(idToken);
        next();
        return;
    }
    catch (e) {
        res.status(401).send('Unauthorized');
        return;
    }
};
const adminMiddleware = async (req, res, next) => {
    try {
        const account = await accounts_1.getAccountFromUserId(res.locals.user.uid);
        // @ts-ignore
        if (account.role !== 'ADMIN') {
            res.status(401).send('Unauthorized');
            return;
        }
        next();
        return;
    }
    catch (e) {
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
    res.send(await accounts_1.getAccountFromUserId(res.locals.user.uid));
});
app.post('/account', async (req, res, _next) => {
    const existAccount = await accounts_1.getAccountFromUserId(res.locals.user.uid);
    if (existAccount) {
        res.send(existAccount);
    }
    else {
        const account = await accounts_1.createAccount({ userId: res.locals.user.uid });
        res.send(account);
    }
});
// GROUPS
app.get('/groups', async (req, res, _next) => {
    const account = await accounts_1.getAccountFromUserId(res.locals.user.uid);
    res.send(await groups_1.getGroup(account));
});
app.post('/groups', adminMiddleware, middlewares_1.validationMiddleware(types_1.AddGroupData, 'body'), async (req, res, _next) => {
    res.send(await groups_1.addGroup(req.body));
});
// ROLES
app.get('/roles', async (req, res, _next) => {
    res.send(await roles_1.listAccountRoles(res.locals.user.uid));
});
app.post('/roles', adminMiddleware, middlewares_1.validationMiddleware(types_2.AddRoleData, 'body'), async (req, res, _next) => {
    res.send(await roles_1.addRole(req.body));
});
// PROJECTS
app.get('/projects', async (req, res, _next) => {
    res.send(await projects_1.listAccountProjects(res.locals.user.uid));
});
app.post('/projects', middlewares_1.validationMiddleware(types_3.AddProjectData, 'body'), async (req, res, _next) => {
    res.send(await projects_1.addProject(res.locals.user.uid, req.body));
});
/*
app.put('/posts/:id/like', async (req, res, _next) => {
  const account = await getAccountFromUserId(admin.firestore(), res.locals.user.uid);
  res.send(await likePost(admin.firestore(), admin.firestore.FieldValue.increment(1), admin.firestore.FieldValue.arrayUnion, req.params.id, account));
});
 */
exports.api = functions.https.onRequest(app);
//# sourceMappingURL=index.js.map