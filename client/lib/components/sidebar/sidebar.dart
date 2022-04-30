import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:client/constant/my_colors.dart';

class Sidebar extends StatefulWidget {
  final int selectedIndex;
  const Sidebar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  List<String> sidebarItems = ["/home", "/groups", "/profile"];

  @override
  Widget build(BuildContext context) {
    return SideNavigationBar(
      selectedIndex: widget.selectedIndex,
      items: const [
        SideNavigationBarItem(
          icon: Icons.home,
          label: 'Home',
        ),
        SideNavigationBarItem(
          icon: Icons.groups,
          label: 'Groups',
        ),
        // SideNavigationBarItem(
        //   icon: Icons.dashboard,
        //   label: 'Projects',
        // ),
        SideNavigationBarItem(
          icon: Icons.person,
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        // final snackBar = SnackBar(
        //   content: Text('Navigate to ${sidebarItems[index]}'),
        //   action: SnackBarAction(
        //     label: 'Undo',
        //     onPressed: () {
        //       // Some code to undo the change.
        //     },
        //   ),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pushNamed(sidebarItems[index]);
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
    );
  }
}
