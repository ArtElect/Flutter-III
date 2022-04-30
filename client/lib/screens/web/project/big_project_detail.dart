import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'package:client/components/navbar/navbar.dart';
import 'package:client/components/sidebar/sidebar.dart';

import 'package:client/models/project_model.dart';
import 'package:client/models/group_projects_model.dart';
import 'package:client/models/right_model.dart';
import 'package:client/services/project.dart';

import 'package:client/constant/my_colors.dart';
import 'package:client/utils/color_checker.dart';

class ProjectDetailScreenArguments {
  final String groupId;
  final String roleName;
  final List<RightModel> rights;
  final String projectId;

  ProjectDetailScreenArguments({
    required this.groupId,
    required this.roleName,
    required this.rights,
    required this.projectId,
  });
}

class BigProjectDetailPage extends StatefulWidget {
  const BigProjectDetailPage({Key? key}) : super(key: key);

  @override
  State<BigProjectDetailPage> createState() => _BigProjectDetailPageState();
}

class _BigProjectDetailPageState extends State<BigProjectDetailPage> {
  final ProjectService _projectService = ProjectService();
  late ProjectDetailScreenArguments screenArgv;
  late ProjectModel project;
  late List<RightModel> rights;

  List<Widget> _buildActionButton({required List<RightModel> rights}) {
    List<Widget> childs = [];
    for (var right in rights) {
      if (right.name == "Create") {
        childs.add(
          Tooltip(
            message: "You can ${right.name.toLowerCase()} new project",
            child: GFButton(
              text: right.name,
              color: ColorChecker.getColorByName(name: right.name),
              shape: GFButtonShape.pills,
              onPressed: () {},
            ),
          ),
        );
      } else if (right.name == "UPDATE") {
        childs.add(
          Tooltip(
            message: "You can ${right.name.toLowerCase()} this project",
            child: GFButton(
              text: right.name,
              color: ColorChecker.getColorByName(name: right.name),
              shape: GFButtonShape.pills,
              onPressed: () {},
            ),
          ),
        );
      } else if (right.name == "Delete") {
        childs.add(
          Tooltip(
            message: "You can ${right.name.toLowerCase()} this project",
            child: GFButton(
              text: right.name,
              color: ColorChecker.getColorByName(name: right.name),
              shape: GFButtonShape.pills,
              onPressed: () {},
            ),
          ),
        );
      }
    }
    return childs;
  }

  Widget _buildHeader({
    required String name,
    required List<RightModel> rights,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ..._buildActionButton(rights: rights),
      ],
    );
  }

  Widget _buildAvatarContainer({required ProjectModel project}) {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          project.image != ""
              ? GFAvatar(
                  shape: GFAvatarShape.square,
                  backgroundImage: NetworkImage(project.image!),
                  radius: 100.0,
                )
              : GFAvatar(
                  shape: GFAvatarShape.square,
                  child: Center(
                    child: Text(project.title![0],
                        style: const TextStyle(fontSize: 60)),
                  ),
                  radius: 100.0,
                ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Group ID: ${screenArgv.groupId}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Project ID: ${project.id}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  GFButton(
                    text: screenArgv.roleName,
                    color: ColorChecker.getColorByLength(
                      length: screenArgv.rights.length,
                    ),
                    shape: GFButtonShape.pills,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformationContainer({required ProjectModel project}) {
    return Row(children: []);
  }

  Widget _buildContent({required ProjectModel project}) {
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
            _buildHeader(name: project.title!, rights: rights),
            const Divider(thickness: 1),

            _buildAvatarContainer(project: project)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenArgv = ModalRoute.of(context)!.settings.arguments
        as ProjectDetailScreenArguments;

    return Scaffold(
      appBar: const Navbar(),
      body: Row(
        children: [
          const Sidebar(selectedIndex: 1),
          FutureBuilder<List<GroupProjectsModel>>(
            future: _projectService.getGroupsProjects(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                project = _projectService.getProjectByGroupIdAndProjectId(
                  groupId: screenArgv.groupId,
                  projectId: screenArgv.projectId,
                );
                rights = screenArgv.rights;
                return _buildContent(project: project);
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
