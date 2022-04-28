import 'package:admin/components/sidebar.dart';
import 'package:admin/models/groups_model.dart';
import 'package:admin/services/group_service.dart';
import 'package:admin/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class GroupsDetailPage extends StatefulWidget {
  final GroupsModel groupsModel;
  GroupsDetailPage({ Key? key, required this.groupsModel}) : super(key: key);

  @override
  _GroupsDetailPageState createState() => _GroupsDetailPageState();
}

class _GroupsDetailPageState extends State<GroupsDetailPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  final GroupService _groupService = GroupService();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: Row(
            children: [
              const Sidebar(selectedIndex: 1),
              Expanded(
                child: Center(
                  child: Card(
                    child: SizedBox(
                      height: 400,
                      width: 400,
                      child: Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: widget.groupsModel.title
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 10)),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: _descriptionController,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: widget.groupsModel.description
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 10)),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _groupService.updateGroup(
                                      _titleController.text.isEmpty ? widget.groupsModel.title! : _titleController.text,
                                      _descriptionController.text.isEmpty ? widget.groupsModel.description! : _descriptionController.text,
                                      widget.groupsModel.id!);
                                });
                              },
                              child: const Text("Update"),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.blue
                              )
                          )
                        ],
                      ),
                    )
                  ),
                ),
              )
            ]
        )
    );
  }
}