const admin = require('firebase-admin'); // required

// initialization
const projectId = 'flutter-iii-8a868';
process.env.FIRESTORE_EMULATOR_HOST = 'localhost:8080';
admin.initializeApp({ projectId });

const rights = ['CREATE', 'READ', 'UPDATE', 'DELETE'];

const groups = [{
    name: 'GAME DEV',
    description: 'Description du groupe GAME DEV',
    image: 'imageUrl'
  }, {
    name: 'APP DEV',
    description: 'Description du groupe APP DEV',
    image: 'imageUrl'
  }, {
    name: 'WEB DEV',
    description: 'Description du groupe WEB DEV',
    image: 'imageUrl'
  }, {
    name: 'IOT ARCHITECTURE',
    description: 'Description du groupe IOT ARCHITECTURE',
    image: 'imageUrl'
  }, {
    name: 'BLUETOOTH LE',
    description: 'Description du groupe BLUETOOTH LE',
    image: 'imageUrl'
  }, {
    name: 'MACHINE LEARNING',
    description: 'Description du groupe MACHINE LEARNING',
    image: 'imageUrl'
  }
];

const seedDb = async () => {
  await Promise.all(rights.map(async (r) => admin.firestore().collection('right').add({ action: r })));
  await Promise.all(groups.map(async (g) => admin.firestore().collection('group').add(g)));
}

seedDb();
