import 'package:flutter/material.dart';
import 'package:flutter_iii/routes/routes.dart';

class Sidebar extends StatefulWidget {
  final String selectedTab;
  const Sidebar({Key? key, required this.selectedTab}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   decoration: BoxDecoration(
    //     border: Border(
    //       right: BorderSide(color: Colors.grey.shade200, width: 2),
    //     ),
    //   ),
    //   padding: const EdgeInsets.all(20),
    //   child: Column(
    //     children: [
    //       ListTile(
    //         leading: const Icon(Icons.group),
    //         title: const Text("Groups"),
    //         selected: widget.selectedTab == "Groups",
    //         onTap: () => {
    //           // Navigator.push(
    //           //   context,
    //           //   MaterialPageRoute(builder: (context) => const Groups()),
    //           // ),
    //           Navigator.of(context).pushNamed(Routes.groups)
    //         },
    //       ),
    //       ListTile(
    //         leading: const Icon(Icons.account_circle_outlined),
    //         title: const Text("Users"),
    //         selected: widget.selectedTab == "Users",
    //         onTap: () => {
    //           Navigator.of(context).pushNamed(Routes.users)
    //           // Navigator.push(
    //           //   context,
    //           //   MaterialPageRoute(builder: (context) => const Users()),
    //           // )
    //         },
    //       ),
    //     ],
    //   ),
    // );
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'My Admin',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text("Groups"),
            selected: widget.selectedTab == "Groups",
            onTap: () => {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Groups()),
              // ),
              Navigator.of(context).pushNamed(Routes.groups)
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text("Users"),
            selected: widget.selectedTab == "Users",
            onTap: () => {
              Navigator.of(context).pushNamed(Routes.users)
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Users()),
              // )
            },
          ),
        ],
      ),
    );
  }
}
