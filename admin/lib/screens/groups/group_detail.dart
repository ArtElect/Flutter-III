import 'package:admin/components/sidebar.dart';
import 'package:admin/models/groups_model.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/services/group_service.dart';
import 'package:admin/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class GroupsDetailPage extends StatefulWidget {
  final GroupsModel groupsModel;
  const GroupsDetailPage({ Key? key, required this.groupsModel}) : super(key: key);

  @override
  _GroupsDetailPageState createState() => _GroupsDetailPageState();
}

class _GroupsDetailPageState extends State<GroupsDetailPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final GroupService _groupService = GroupService();

  @override
  void initState() {
    super.initState();
    _titleController.value = _titleController.value.copyWith(text: widget.groupsModel.name);
    _descriptionController.value = _descriptionController.value.copyWith(text: widget.groupsModel.description);
    _imageController.value = _descriptionController.value.copyWith(text: widget.groupsModel.image!);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _titleController.dispose();
    _imageController.dispose();
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
                          Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(widget.groupsModel.image!),
                                  )
                              )
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 10)),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'Title',
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
                                  labelText: 'Description',
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 10)),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: _imageController,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'ImageUrl',
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 10)),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _groupService.updateGroup(
                                      _titleController.text.isEmpty ? widget.groupsModel.name! : _titleController.text,
                                      _descriptionController.text.isEmpty ? widget.groupsModel.description! : _descriptionController.text,
                                      _imageController.text.isEmpty ? widget.groupsModel.image! : _imageController.text,
                                      widget.groupsModel.id!);
                                  Navigator.of(context).popAndPushNamed(Routes.groups);
                                });
                              },
                              child: const Text("Update"),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.blue
                              )
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 10)),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _groupService.deleteGroup(widget.groupsModel.id!);
                                  Navigator.of(context).popAndPushNamed(Routes.groups);
                                });
                              },
                              child: const Text("Delete"),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.red
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