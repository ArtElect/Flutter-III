import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:admin/config/my_colors.dart';

class Sidebar extends StatefulWidget {
  final int selectedIndex;
  const Sidebar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  List<String> sidebarItems = ["/home", "/groups", "/projects", "/profile"];

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
        SideNavigationBarItem(
          icon: Icons.dashboard,
          label: 'Project',
        ),
        SideNavigationBarItem(
          icon: Icons.person,
          label: 'Profile',
        ),
      ],
      onTap: (index) {
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
