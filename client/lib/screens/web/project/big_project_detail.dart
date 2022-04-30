import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:client/routes/routes.dart';

import 'package:client/components/navbar/navbar.dart';
import 'package:client/components/sidebar/sidebar.dart';
import 'package:client/components/cards/role_members_card.dart';

import 'package:client/models/project_model.dart';
import 'package:client/models/group_projects_model.dart';
import 'package:client/models/right_model.dart';
import 'package:client/models/user_model.dart';
import 'package:client/services/project.dart';
import 'package:client/screens/web/project/big_project_update.dart';

import 'package:client/constant/my_colors.dart';
import 'package:client/utils/color_checker.dart';

class ProjectDetailScreenArguments {
  final String groupId;
  final String roleName;
  final List<UserModel> members;
  final List<RightModel> rights;
  final String projectId;

  ProjectDetailScreenArguments({
    required this.groupId,
    required this.roleName,
    required this.members,
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

  List<Widget> _buildActionButton() {
    List<Widget> childs = [];
    for (var right in rights) {
      if (right.name == "UPDATE") {
        childs.add(
          Tooltip(
            message: "You can ${right.name.toLowerCase()} this project",
            child: GFButton(
              text: right.name,
              color: ColorChecker.getColorByName(name: right.name),
              shape: GFButtonShape.pills,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  Routes.projectUpdate,
                  arguments: ProjectUpdateScreenArguments(
                    groupId: screenArgv.groupId,
                    roleName: screenArgv.roleName,
                    project: project,
                  ),
                );
              },
            ),
          ),
        );
      } else if (right.name == "DELETE") {
        childs.add(
          Tooltip(
            message: "You can ${right.name.toLowerCase()} this project",
            child: GFButton(
              text: right.name,
              color: ColorChecker.getColorByName(name: right.name),
              shape: GFButtonShape.pills,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete project'),
                    content: const Text(
                      'Are you sure you want to delete this project ? You can\'t get it back !',
                    ),
                    actions: [
                      GFButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      GFButton(
                        color: GFColors.DANGER,
                        onPressed: () {
                          print("Delete project ");
                        },
                        child: const Text('Confirm'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }
    }
    return childs;
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ..._buildActionButton(),
      ],
    );
  }

  Widget _buildAvatarContainer({required ProjectModel project}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        project.image != ""
            ? GFAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(project.image!),
                radius: 100.0,
              )
            : GFAvatar(
                backgroundColor: Colors.grey,
                child: Center(
                  child: Text(
                    project.title![0],
                    style: const TextStyle(fontSize: 60),
                  ),
                ),
                radius: 100.0,
              ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
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
    );
  }

  Widget _buildInformationContainer({required ProjectModel project}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.title!,
          style: const TextStyle(
            color: MyColors.text,
            fontWeight: FontWeight.bold,
            fontSize: 36,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          project.description!,
          style: const TextStyle(
            color: MyColors.subtext,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
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
            _buildHeader(),
            const Divider(thickness: 1),
            Expanded(
              flex: 3,
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        margin: const EdgeInsets.only(bottom: 10),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: _buildAvatarContainer(project: project),
                            ),
                            Expanded(
                              flex: 3,
                              child:
                                  _buildInformationContainer(project: project),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 10),
                        child: RoleMembersCard(
                          name: project.title!,
                          members: screenArgv.members,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                // color: Colors.purple,
                // child: Text("Statistics"),
              ),
            )
            // _buildAvatarContainer(project: project),
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
