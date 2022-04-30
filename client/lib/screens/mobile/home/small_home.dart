import 'package:client/screens/mobile/home/group_carousel.dart';
import 'package:client/services/fire_auth.dart';
import 'package:flutter/material.dart';
import 'package:client/constant/my_colors.dart';
import 'package:client/screens/mobile/drawer/navigation_drawer.dart';

class SmallHomePage extends StatefulWidget {

  const SmallHomePage({Key? key}) : super(key: key);

  @override
  _SmallHomePageState createState() => _SmallHomePageState();
}

class _SmallHomePageState extends State<SmallHomePage> {
  final FireAuthService _fireAuthService = FireAuthService();

  final List<String> images = [
    'https://wallpaperaccess.com/full/170249.jpg',
    'https://wallpaperaccess.com/full/114310.jpg',
    'https://resi.ze-robot.com/dl/4k/4k-landscape-wallpaper-3440%C3%971440.jpg',
    'https://i.pinimg.com/736x/7f/fd/db/7ffddbbc3b314d64f5c7798be29ab9be.jpg',
    'https://wallpaperaccess.com/full/3051108.jpg',
    'https://i.redd.it/dq7zpx79hnu61.jpg',
  ];

  final List<String> projects = [
    'GAME DEV',
    'APP DEV',
    'WEB DEV',
    'IOT ARCHITECTURE',
    'BLUETOOTH LE',
    'MACHINE LEARNING',
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawerEdgeDragWidth: 0,
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: MyColors.appBarBgColor,
        title: const Text(
          'EPITECH',
          style: TextStyle(
            fontSize: 24,
            letterSpacing: 3,
          ),
        ),
      ),
      body: FutureBuilder<String>(
        future: _fireAuthService.getIdToken,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            print(snapshot.data);
            // _fireAuthService.createAccountInDB(snapshot.data.toString());
            return SingleChildScrollView(
              child: Column(
                children: [
                  GroupCarousel(title: 'Flutter', images: images, projects: projects,),
                  GroupCarousel(title: 'Java', images: images, projects: projects,),
                  GroupCarousel(title: 'Python', images: images, projects: projects,),
                  GroupCarousel(title: 'Unreal Engine', images: images, projects: projects,),
                  GroupCarousel(title: 'Unity', images: images, projects: projects,),
                ],
              ),
            );
          } else {
            print('${snapshot.error}');
            return const Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }
}