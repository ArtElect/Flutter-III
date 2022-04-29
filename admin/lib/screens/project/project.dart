import 'package:admin/components/sidebar.dart';
import 'package:admin/models/groups_model.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/services/project_service.dart';
import 'package:admin/widgets/custom_app_bar.dart';
import 'package:admin/screens/project/project_datatable.dart';
import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({ Key? key }) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final ProjectService _projectService = ProjectService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Row(
        children: [
          const Sidebar(selectedIndex: 2),
          Flexible(
            child: FutureBuilder<List<GroupsModel>>(
              future: _projectService.fetchProjects(),
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
                                  Text('Projects', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                                ],
                              ),
                              ProjectDatatable(groups: snapshot.data!),
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
          Navigator.of(context).popAndPushNamed(Routes.addProject);
        }
      ),
    );
  }
}