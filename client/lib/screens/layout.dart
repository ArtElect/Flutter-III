import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:client/components/navbar/navbar.dart';
import 'package:client/screens/home.dart';
import 'package:client/screens/groups.dart';
import 'package:client/screens/profile.dart';
import 'package:client/constant/my_colors.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({Key? key}) : super(key: key);

  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  /// Views to display
  List<Widget> views = const [
    HomePage(),
    GroupsPage(),
    ProfilePage(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// You can use an AppBar if you want to
      appBar: const Navbar(),

      // The row is needed to display the current view
      body: Row(
        children: [
          /// Pretty similar to the BottomNavigationBar!
          SideNavigationBar(
            selectedIndex: selectedIndex,
            items: const [
              SideNavigationBarItem(
                icon: Icons.home,
                label: 'Home',
              ),
              SideNavigationBarItem(
                icon: Icons.groups,
                label: 'Groups',
              ),
              SideNavigationBarItem(
                icon: Icons.person,
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },

            theme: SideNavigationBarTheme(
              backgroundColor: MyColors.headline,
              togglerTheme: SideNavigationBarTogglerTheme.standard(),
              itemTheme: const SideNavigationBarItemTheme(
                selectedItemColor: Colors.white,
                unselectedItemColor: MyColors.lightPurple,
              ),
              dividerTheme: SideNavigationBarDividerTheme.standard(),
            ),
          ),

          /// Make it take the rest of the available width
          Expanded(
            child: views.elementAt(selectedIndex),
          )
        ],
      ),
    );
  }
}