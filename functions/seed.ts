const admin = require('firebase-admin'); // required

// initialization
const projectId = 'flutter-iii-8a868';
process.env.FIRESTORE_EMULATOR_HOST = 'localhost:8000';
admin.initializeApp({ projectId });

const rights = ['CREATE', 'READ', 'UPDATE', 'DELETE'];

const groups = [{
    name: 'GAME DEV',
    description: 'GAME DEV group description',
    image: 'https://i0.wp.com/hipther.com/wp-content/uploads/2021/11/five-ai-tools-every-game-developer-should-have-in-their-toolbelt.jpg?resize=696%2C463&ssl=1',
  }, {
    name: 'APP DEV',
    description: 'APP DEV group description',
    image: 'https://news.gandi.net/wp-content/uploads/2018/11/domain_dev_23222b-1024x512.jpg'
  }, {
    name: 'WEB DEV',
    description: 'WEB DEV group description',
    image: 'https://news.gandi.net/wp-content/uploads/2018/11/domain_dev_23222b-1024x512.jpg'
  }, {
    name: 'IOT ARCHITECTURE',
    description: 'IOT ARCHITECTURE group description',
    image: 'https://www.portices.fr/wp-content/uploads/2021/08/Internet-of-Things-IoT.jpg'
  }, {
    name: 'BLUETOOTH LE',
    description: 'BLUETOOTH LE group description',
    image: 'https://www.mokoblue.com/wp-content/uploads/2021/03/%E4%B8%BB%E5%9B%BE-1.webp'
  }, {
    name: 'MACHINE LEARNING',
    description: 'MACHINE LEARNING group description',
    image: 'https://www.jeveuxetredatascientist.fr/wp-content/uploads/2015/01/shutterstock_1092234560-1080x652.jpg'
  }
];

const seedDb = async () => {
  await Promise.all(rights.map(async (r) => admin.firestore().collection('right').add({ action: r })));
  await Promise.all(groups.map(async (g) => admin.firestore().collection('group').add(g)));
  await admin.firestore().collection('account').add({
    firstname: 'admin',
    lastname: 'admin',
    pseudo: 'admin',
    image: 'admin',
    role: 'ADMIN',
    userId: 'to be set',
  })
}

seedDb();
