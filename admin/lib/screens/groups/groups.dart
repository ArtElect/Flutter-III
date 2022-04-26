import 'package:admin/components/sidebar.dart';
import 'package:admin/models/groups_model.dart';
import 'package:admin/services/group_service.dart';
import 'package:admin/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({ Key? key }) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final GroupService _groupService = GroupService();

  List<Widget> _generateText(List<GroupsModel>? groups) {
    List<Widget> result = [];
    for(var data in groups!) {
      result.add(
        Center(
          heightFactor: 1.5,
          child: InkWell(
            child: ListTile(
              title: Text(data.title ?? 'null', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              subtitle: Text(data.description ?? 'null', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            ),
            onTap: (){},
          ),
        ),
      );
    }
    return result;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Row(
        children: [
          const Sidebar(selectedIndex: 1),
          Expanded(
            child: FutureBuilder<List<GroupsModel>>(
              future: _groupService.fetchGroups(),
              builder: (context, snapshot) {
                if(snapshot.data != null) {
                  return SingleChildScrollView(
                    child: Column(
                      children:  _generateText(snapshot.data),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}