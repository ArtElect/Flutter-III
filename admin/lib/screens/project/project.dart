import 'package:admin/components/sidebar.dart';
import 'package:admin/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({ Key? key }) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Row(
        children: const [
          Sidebar(selectedIndex: 2),
          Expanded(
            child: Center(
              child: Text("Project Page")
            )
          )
        ],
      ),
    );
  }
}