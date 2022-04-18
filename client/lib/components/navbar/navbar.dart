import 'package:flutter/material.dart';

class Navbar extends StatelessWidget with PreferredSizeWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Center(
        child: Text('Epitech Dashboard', textAlign: TextAlign.center),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'Logout',
          onPressed: () {},
        ),
      ],
    );
  }
}
