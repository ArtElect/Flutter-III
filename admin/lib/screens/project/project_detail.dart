import 'package:admin/components/sidebar.dart';
import 'package:admin/models/project_model.dart';
import 'package:admin/routes/routes.dart';
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
                content: Column(
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
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
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
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
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
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'ImageUrl',
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _projectService.updateProject(
                            _titleController.text.isEmpty ? widget.project.title! : _titleController.text,
                            _descriptionController.text.isEmpty ? widget.project.description! : _descriptionController.text,
                            _imageController.text.isEmpty ? widget.project.image! : _imageController.text,
                            widget.project.groupId!,
                            widget.project.projectId!,
                          );
                          Navigator.of(context).popAndPushNamed(Routes.projects);
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
          )
        ]
      )
    );
  }
}