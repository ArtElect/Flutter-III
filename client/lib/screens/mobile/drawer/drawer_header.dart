import 'package:flutter/material.dart';
import 'package:client/constant/my_images.dart';

Widget buildDrawerHeader() {
  return DrawerHeader(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    decoration: const BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(MyImages.drawerHeaderBg),
      )
    ),
    child: Container(),
  );
}