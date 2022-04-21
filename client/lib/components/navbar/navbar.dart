import 'package:client/services/fire_auth.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget with PreferredSizeWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Center(
        child: Text('Epitech Dashboard', textAlign: TextAlign.center),
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
