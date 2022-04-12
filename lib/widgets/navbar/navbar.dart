import 'package:flutter/material.dart';
import 'package:flutter_iii/components/avatar/avatar.dart';

class Navbar extends StatelessWidget with PreferredSizeWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('My Admin'),
      actions: <Widget>[
        // IconButton(
        //   icon: const Icon(Icons.add_alert),
        //   tooltip: 'Show Snackbar',
        //   onPressed: () {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(content: Text('This is a snackbar')));
        //   },
        // ),
        const Avatar(username: "Zhiwen"),
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'Logout',
          onPressed: () {},
        ),
      ],
    );
  }
}
