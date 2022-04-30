import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:client/routes/routes.dart';
import 'package:client/components/navbar/navbar.dart';
import 'package:client/components/sidebar/sidebar.dart';
import 'package:client/components/cards/group_card.dart';
import 'package:client/components/empty/empty_body.dart';
import 'package:client/components/unauthorized/unauthorized.dart';

import 'package:client/models/group_projects_model.dart';
import 'package:client/models/project_model.dart';
import 'package:client/models/right_model.dart';
import 'package:client/models/user_model.dart';
import 'package:client/services/project.dart';

import 'package:client/screens/web/project/big_project_detail.dart';
import 'package:client/screens/web/project/big_project_create.dart';

import 'package:client/constant/my_colors.dart';
import 'package:client/utils/color_checker.dart';

class ProjectsScreenArguments {
  final String groupId;
  final String roleName;
  final List<UserModel> members;
  final List<RightModel> rights;

  ProjectsScreenArguments({
    required this.groupId,
    required this.roleName,
    required this.rights,
    required this.members,
  });
}

class BigProjectsPage extends StatefulWidget {
  const BigProjectsPage({Key? key}) : super(key: key);

  @override
  State<BigProjectsPage> createState() => _BigProjectsPageState();
}

class _BigProjectsPageState extends State<BigProjectsPage> {
  final ProjectService _projectService = ProjectService();
  late ProjectsScreenArguments screenArgv;
  late GroupProjectsModel group;
  late List<RightModel> rights;

  Widget _buildCreateButton({required List<RightModel> rights}) {
    for (var right in rights) {
      if (right.name == "CREATE") {
        return Tooltip(
          message: "You can ${right.name.toLowerCase()} project(s)",
          child: GFButton(
            text: right.name,
            color: ColorChecker.getColorByName(name: right.name),
            shape: GFButtonShape.pills,
            onPressed: () {
              Navigator.of(context).pushNamed(
                Routes.projectCreate,
                arguments: ProjectCreateScreenArguments(
                  groupId: screenArgv.groupId,
                  roleName: screenArgv.roleName,
                ),
              );
            },
          ),
        );
      }
    }
    return Container();
  }

  Widget _buildHeader({
    required String name,
    required List<RightModel> rights,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              "List of $name projects",
              style: const TextStyle(
                color: MyColors.text,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(width: 20),
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
        _buildCreateButton(rights: rights),
      ],
    );
  }

  Widget _buildContent(List<GroupProjectsModel> groups) {
    group = _projectService.getProjectsByGroupId(groupId: screenArgv.groupId);
    rights = screenArgv.rights;

    if (groups.isEmpty || rights.isEmpty) {
      return const Expanded(child: UnauthorizedBody());
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
          _buildHeader(name: group.group.name, rights: rights),
          const Divider(thickness: 1),
          Expanded(
            child: group.projects.isNotEmpty
                ? Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                            Navigator.of(context).pushNamed(
                              Routes.projectDetail,
                              arguments: ProjectDetailScreenArguments(
                                groupId: screenArgv.groupId,
                                roleName: screenArgv.roleName,
                                members: screenArgv.members,
                                projectId: group.projects[index].id!,
                                rights: rights,
                              ),
                            ),
                          },
                        );
                      },
                    ),
                  )
                : const EmptyBody(str: "No project was found"),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    screenArgv =
        ModalRoute.of(context)!.settings.arguments as ProjectsScreenArguments;

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
