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

  List<Widget> _generateText(GroupsModel? group) {
    List<Widget> result = [];
      result.add(
        Center(
          heightFactor: 1.5,
          child: InkWell(
            child: ListTile(
              title: Text(group!.title ?? 'null', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              subtitle: Text(group.description ?? 'null', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            ),
            onTap: () {
              Navigator.of(context).popAndPushNamed("/groups/detail", arguments: group);
            },
          ),
        ),
      );
    return result;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Row(
        children: [
          const Sidebar(selectedIndex: 1),
          Flexible(
            child: FutureBuilder<List<GroupsModel>>(
              future: _groupService.fetchGroups(),
              builder: (context, snapshot) {
                if(snapshot.data != null) {
                  return ListView.builder(
                    controller: ScrollController(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children:  _generateText(snapshot.data![index]),
                      );
                    },
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