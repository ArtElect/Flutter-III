import 'package:flutter/material.dart';
import 'package:client/routes/routes.dart';

class Sidebar extends StatefulWidget {
  final String selectedTab;
  const Sidebar({Key? key, required this.selectedTab}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                'Epitech Dashboard',
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
            title: const Text("Dashboard"),
            selected: widget.selectedTab == "Dashboard",
            onTap: () => {
              Navigator.of(context).pushNamed(Routes.dashboard)
            },
          ),
        ],
      ),
    );
  }
}
