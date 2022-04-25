import 'package:admin/components/sidebar.dart';
import 'package:admin/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({ Key? key }) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Row(
        children: const [
          Sidebar(selectedIndex: 1),
          Expanded(
            child: Center(
              child: Text("Group Page")
            )
          )
        ],
      ),
    );
  }
}