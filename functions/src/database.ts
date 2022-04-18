import * as admin from "firebase-admin";
const databaseURL = 'https://flutter-iii-8a868-default-rtdb.europe-west1.firebasedatabase.app';

admin.initializeApp({
  databaseURL,
  credential: admin.credential.applicationDefault(),
});

export default admin;
