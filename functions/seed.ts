const admin = require('firebase-admin'); // required

// initialization
const projectId = 'flutter-iii-8a868';
process.env.FIRESTORE_EMULATOR_HOST = 'localhost:8080';
admin.initializeApp({ projectId });

const rights = ['CREATE', 'READ', 'UPDATE', 'DELETE'];

const groups = [{
    name: 'GAME DEV',
    description: 'Description du groupe GAME DEV'
  }, {
    name: 'APP DEV',
    description: 'Description du groupe APP DEV'
  }, {
    name: 'WEB DEV',
    description: 'Description du groupe WEB DEV'
  }, {
    name: 'IOT ARCHITECTURE',
    description: 'Description du groupe IOT ARCHITECTURE'
  }, {
    name: 'BLUETOOTH LE',
    description: 'Description du groupe BLUETOOTH LE'
  }, {
    name: 'MACHINE LEARNING',
    description: 'Description du groupe MACHINE LEARNING'
  }
];

const seedDb = async () => {
  await Promise.all(rights.map(async (r) => admin.firestore().collection('right').add({ action: r })));
  await Promise.all(groups.map(async (g) => admin.firestore().collection('group').add(g)));
}

seedDb();
