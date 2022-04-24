import 'package:client/constant/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildDrawerBodyItem({required FaIcon icon, required String text, required GestureTapCallback? onTap}) {
  return ListTile(
    title: Row(
      children: [
        icon,
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(text, style: const TextStyle(color: MyColors.drawerTextColor, fontSize: 14),),
        )
      ],
    ),
    onTap: onTap,
  );
}