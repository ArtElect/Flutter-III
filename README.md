# flutter-III

### Firebase initialization

**<ins>Step 1</ins>**

run "firebase emulators:start" cmd

the result should be like this

![alt text](assets/firebase.png)

**<ins>Step 2</ins>**

Click on the "Authentication" emulator UI link and create an account on it

Copy the generated userId

**<ins>Step 3</ins>**

You will now seed the database

run "cd functions/"

run "npm run db:seed" (warning: don't run this cmd more than once)

**<ins>Step 4</ins>**

Click on the "Firestore" emulator UI link.

Now you can click on the account collection, you will see an admin account, you can now change the userId by your own.

You have finished the initialization of firebase
