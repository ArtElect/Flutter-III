import 'package:admin/components/sidebar.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/screens/project/project_dropdownfield.dart';
import 'package:admin/screens/project/project_textfield.dart';
import 'package:admin/services/project_service.dart';
import 'package:admin/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({Key? key}) : super(key: key);

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  final _formKey = GlobalKey<FormState>();
  final ProjectService _projectService = ProjectService();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Row(
        children: [
          const Sidebar(selectedIndex: 2),
          Flexible(
            child: Center(
              child: GFCard(
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                    const SizedBox(height: 30,),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          ProjectTextField(
                            label: 'Title',
                            errorMessage: 'Invalid title',
                            controller: _titleController,
                          ),
                          ProjectTextField(
                            label: 'Description',
                            errorMessage: 'Invalid description',
                            controller: _descriptionController,
                          ),
                          ProjectTextField(
                            label: 'Image url',
                            errorMessage: 'Invalid image url',
                            controller: _imageController,
                          ),
                          ProjectDropdownfield(onSelectParam: (value) => setState(() => _selectedValue = value)),
                          const SizedBox(height: 40,),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _projectService.createProject(_titleController.text, _descriptionController.text, _imageController.text, _selectedValue!);
                                Navigator.of(context).popAndPushNamed(Routes.projects);
                                setState(() {});
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.blue
                            ),
                            child: const Text(
                              'Create',
                              style: TextStyle(fontWeight: FontWeight.bold,),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}