import 'package:admin/components/sidebar.dart';
import 'package:admin/models/project_model.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/screens/project/project_textfield.dart';
import 'package:admin/services/project_service.dart';
import 'package:admin/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ProjectDetailPage extends StatefulWidget {
  final ProjectModel project;
  const ProjectDetailPage({ Key? key, required this.project}) : super(key: key);

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final ProjectService _projectService = ProjectService();

  @override
  void initState() {
    super.initState();
    _titleController.value = _titleController.value.copyWith(text: widget.project.title);
    _descriptionController.value = _descriptionController.value.copyWith(text: widget.project.description);
    _imageController.value = _descriptionController.value.copyWith(text: widget.project.image!);
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
          const Sidebar(selectedIndex: 2),
          Expanded(
            child: Center(
              child: GFCard(
                content: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Container(
                        width: 200,
                        height: 130,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(widget.project.image!),
                          )
                        )
                      ),
                      const SizedBox(height: 30,),
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
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                              _projectService.updateProject(
                              _titleController.text,
                              _descriptionController.text,
                              _imageController.text,
                              widget.project.groupId!,
                              widget.project.projectId!,
                            );
                            Navigator.of(context).popAndPushNamed(Routes.projects);
                            setState(() {});
                          }
                        },
                        child: const Text("Update"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.blue
                        )
                      ),
                      const SizedBox(height: 10,),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _projectService.deleteGroup(widget.project.groupId!, widget.project.projectId!);
                            Navigator.of(context).popAndPushNamed(Routes.projects);
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
                ),
              ),
            ),
          )
        ]
      )
    );
  }
}