import 'package:flutter/material.dart';
import 'package:client/constant/my_colors.dart';
import 'package:client/routes/routes.dart';
import 'package:client/screens/mobile/drawer/drawer_body_item.dart';
import 'package:client/screens/mobile/drawer/drawer_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          buildDrawerHeader(),
          buildDrawerBodyItem(
            icon: const FaIcon(FontAwesomeIcons.home, color: MyColors.drawerButtonsColor, size: 20.0,),
            text: 'Home',
            onTap: () => Navigator.popAndPushNamed(context, Routes.home),
          ),
          buildDrawerBodyItem(
            icon: const FaIcon(FontAwesomeIcons.projectDiagram, color: MyColors.drawerButtonsColor, size: 20.0,),
            text: 'Projects',
            onTap: () => Navigator.popAndPushNamed(context, Routes.home),
          ),
          buildDrawerBodyItem(
            icon: const FaIcon(FontAwesomeIcons.userAlt, color: MyColors.drawerButtonsColor, size: 20.0,),
            text: 'Profile',
            onTap: () => Navigator.popAndPushNamed(context, Routes.profile),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
          const Divider(color: MyColors.drawerDivierColor, thickness: 0.5,),
          Center(
            child: Text(
              'Copyright © 2021 | EPITECH',
              style: TextStyle(
                color: MyColors.drawerFooterColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}