import 'package:admin/config/my_colors.dart';
import 'package:admin/services/fire_auth.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColors.headline,
      automaticallyImplyLeading: false,
      title: const Center(
        child: Text('Web admin console', textAlign: TextAlign.center),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'Logout',
          onPressed: () => FireAuthService().signOut(),
        ),
      ],
    );
  }
}
