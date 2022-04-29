import 'package:admin/components/sidebar.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/services/group_service.dart';
import 'package:admin/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/card/gf_card.dart';

class AddGroupPage extends StatefulWidget {
  const AddGroupPage({ Key? key}) : super(key: key);

  @override
  _AddGroupPageState createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageController;
  final GroupService _groupService = GroupService();
  bool _validateTitle = false;
  bool _validateDescription = false;
  bool _validateImage = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _imageController = TextEditingController();
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
                child: GFCard(
                  content: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://logowik.com/content/uploads/images/flutter5786.jpg"),
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
                            labelText: "Enter a title",
                            errorText: _validateTitle ? "This field can not be empty" : null,
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
                            border: OutlineInputBorder(),
                            labelText: "Enter a description",
                            errorText: _validateDescription ? "This field can not be empty" : null,
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
                            border: OutlineInputBorder(),
                            labelText: "Enter an image url",
                            errorText: _validateImage ? "This field can not be empty" : null,
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_titleController.text.isEmpty) {
                              _validateTitle = true;
                            } else if (_titleController.text.isNotEmpty) {
                              _validateTitle = false;
                            }
                            if  (_descriptionController.text.isEmpty) {
                              _validateDescription = true;
                            } else if (_descriptionController.text.isNotEmpty) {
                              _validateDescription = false;
                            }
                            if  (_imageController.text.isEmpty) {
                              _validateImage = true;
                            } else if (_imageController.text.isNotEmpty) {
                              _validateImage = false;
                            }
                            if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty && _imageController.text.isNotEmpty) {
                              _groupService.createGroup(
                                _titleController.text,
                                _descriptionController.text,
                                _imageController.text,
                              );
                              Navigator.of(context).popAndPushNamed(Routes.groups);
                            }
                          });
                        },
                        child: const Text("Create"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.blue
                        )
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]
        )
    );
  }
}