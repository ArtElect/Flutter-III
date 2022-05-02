import 'package:client/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:client/components/navbar/navbar.dart';
import 'package:client/components/sidebar/sidebar.dart';
import 'package:getwidget/getwidget.dart';

import 'package:client/models/right_model.dart';
import 'package:client/models/user_model.dart';
import 'package:client/models/project_model.dart';
import 'package:client/services/project.dart';
import 'package:client/screens/web/project/big_project_detail.dart';
import 'package:client/constant/my_colors.dart';

class ProjectUpdateScreenArguments {
  final String roleId;
  final String groupId;
  final String roleName;
  final List<UserModel> members;
  final List<RightModel> rights;
  final ProjectModel project;

  ProjectUpdateScreenArguments({
    required this.roleId,
    required this.groupId,
    required this.roleName,
    required this.project,
    required this.rights,
    required this.members,
  });
}

class BigProjectUpdatePage extends StatefulWidget {
  const BigProjectUpdatePage({Key? key}) : super(key: key);

  @override
  State<BigProjectUpdatePage> createState() => _BigProjectUpdatePageState();
}

class _BigProjectUpdatePageState extends State<BigProjectUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  final ProjectService _projectService = ProjectService();
  late ProjectUpdateScreenArguments screenArgv;
  late ProjectModel project;

  Widget _buildHeader() {
    return const Text(
      "Update project",
      style: TextStyle(
        color: MyColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    );
  }

  Widget _buildAvatarContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          project.image != ""
              ? GFAvatar(
                  backgroundImage: NetworkImage(project.image!),
                  radius: 100.0,
                )
              : GFAvatar(
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
                      color: MyColors.subtext,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Project ID: ${project.id}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: MyColors.subtext,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectFrom() {
    return SizedBox(
      width: 800,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              initialValue: project.title,
              decoration: InputDecoration(
                labelText: 'Project name',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.person),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: MyColors.grey500),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: MyColors.grey500,
                  ),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a project name';
                }
                project.title = value;
                return null;
              },
            ),
            const Divider(thickness: 1, height: 20, color: Colors.white),
            TextFormField(
              initialValue: project.description,
              maxLines: 5,
              minLines: 5,
              decoration: InputDecoration(
                labelText: 'Project description',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.person),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: MyColors.grey500),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: MyColors.grey500,
                  ),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a project name';
                }
                project.description = value;
                return null;
              },
            ),
            const Divider(thickness: 1, height: 20, color: Colors.white),
            TextFormField(
              initialValue: project.image,
              decoration: InputDecoration(
                labelText: 'Project image',
                hintText: 'http://image.com',
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.image),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: MyColors.grey500),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: MyColors.grey500,
                  ),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an image url';
                } else if (!value.contains("http://") &&
                    !value.contains("https://")) {
                  return 'Image must be url type';
                }
                project.image = value;
                return null;
              },
            ),
            GFButton(
              text: "Update",
              color: GFColors.PRIMARY,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var res = await _projectService.updateGroupProject(
                    groupId: screenArgv.groupId,
                    project: project,
                  );
                  if (res) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Update project successful')),
                    );
                    Navigator.of(context).pushNamed(
                      Routes.projectDetail,
                      arguments: ProjectDetailScreenArguments(
                        roleId: screenArgv.roleId,
                        groupId: screenArgv.groupId,
                        roleName: screenArgv.roleName,
                        rights: screenArgv.rights,
                        members: screenArgv.members,
                        projectId: project.id!
                      ),
                    );
                  } else if (!res) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Update project failed')),
                    );
                  } else {
                    const CircularProgressIndicator();
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 30,
        ),
        height: double.infinity,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    _buildAvatarContainer(),
                    _buildProjectFrom(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.all(50),
                child: Center(
                  child: Image.asset('assets/images/update.png'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenArgv = ModalRoute.of(context)!.settings.arguments
        as ProjectUpdateScreenArguments;
    project = screenArgv.project;
    return Scaffold(
      appBar: const Navbar(),
      body: Row(
        children: [
          const Sidebar(selectedIndex: 3),
          _buildContent(),
        ],
      ),
    );
  }
}
