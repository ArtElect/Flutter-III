import 'package:flutter/material.dart';
import 'package:client/components/navbar/navbar.dart';
import 'package:client/components/sidebar/sidebar.dart';
import 'package:client/components/cards/group_card.dart';
import 'package:client/components/empty/empty.dart';
import 'package:client/components/unauthorized/unauthorized.dart';

import 'package:client/models/group_projects_model.dart';
import 'package:client/models/project_model.dart';
import 'package:client/services/project.dart';

import 'package:client/constant/my_colors.dart';

class ProjectsScreenArguments {
  final String groupId;

  ProjectsScreenArguments({required this.groupId});
}

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final ProjectService _projectService = ProjectService();
  late ProjectsScreenArguments screenArgv;
  late GroupProjectsModel group;

  Widget _buildHeader({ required String name}) {
    return Text(
      "List of $name projects",
      style: const TextStyle(
        color: MyColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    );
  }

  Widget _buildContent(List<GroupProjectsModel> groups) {
    if (groups.isEmpty) {
      return const Expanded(child: UnauthorizedBody());
    }
    group = _projectService.getProjectsByGroupId(screenArgv.groupId);
    if (group.projects.length == 0) {
      return const Expanded(child: EmptyBody());
    }
    return Expanded(
        child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 30,
      ),
      height: double.infinity,
      color: MyColors.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(name: group.group.name!),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemCount: group.projects.length,
                itemBuilder: (BuildContext context, int index) {
                  return GroupCard(
                    image:
                        "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
                    name: group.projects[index].title!,
                    description: group.projects[index].title!,
                    onTap: () => {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('On Tap ${group.projects[index].title}'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        ),
                      ),
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    screenArgv = ModalRoute.of(context)!.settings.arguments as ProjectsScreenArguments;

    return Scaffold(
      appBar: const Navbar(),
      body: Row(
        children: [
          const Sidebar(selectedIndex: 1),
          FutureBuilder<List<GroupProjectsModel>>(
            future: _projectService.getGroupsProjects(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return _buildContent(snapshot.data!);
              } else {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
