import 'package:admin/components/sidebar.dart';
import 'package:admin/models/groups_model.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/screens/groups/group_datatable.dart';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                  return Column(
                    children: [
                      SizedBox(
                        width: size.width*0.6,
                        child: SingleChildScrollView(
                          controller: ScrollController(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                children: const [
                                  SizedBox(width: 20),
                                  Text('Groups', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                                ],
                              ),
                              GroupDatatable(groups: snapshot.data!),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).popAndPushNamed(Routes.addGroup);
          }
      ),
    );
  }
}