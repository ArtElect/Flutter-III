"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const admin = require("firebase-admin");
const databaseURL = 'https://flutter-iii-8a868-default-rtdb.europe-west1.firebasedatabase.app';
admin.initializeApp({
    databaseURL,
    credential: admin.credential.applicationDefault(),
});
exports.default = admin;
//# sourceMappingURL=database.js.map