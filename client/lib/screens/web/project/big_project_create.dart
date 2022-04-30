import 'package:client/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:client/components/navbar/navbar.dart';
import 'package:client/components/sidebar/sidebar.dart';
import 'package:getwidget/getwidget.dart';

import 'package:client/models/right_model.dart';
import 'package:client/models/user_model.dart';
import 'package:client/models/project_model.dart';
import 'package:client/services/project.dart';
import 'package:client/screens/web/project/big_projects.dart';
import 'package:client/constant/my_colors.dart';

class ProjectCreateScreenArguments {
  final String roleId;
  final String groupId;
  final String roleName;
  final List<UserModel> members;
  final List<RightModel> rights;

  ProjectCreateScreenArguments({
    required this.roleId,
    required this.groupId,
    required this.roleName,
    required this.rights,
    required this.members,
  });
}

class BigProjectCreatePage extends StatefulWidget {
  const BigProjectCreatePage({Key? key}) : super(key: key);

  @override
  State<BigProjectCreatePage> createState() => _BigProjectCreatePageState();
}

class _BigProjectCreatePageState extends State<BigProjectCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final ProjectService _projectService = ProjectService();
  late ProjectCreateScreenArguments screenArgv;
  final ProjectModel _project =
      ProjectModel(id: "", title: "", description: "", image: "");

  Widget _buildHeader() {
    return const Text(
      "Create new project",
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
      child: Center(
        child: GFAvatar(
          child: Center(
            child: Text(
              _project.title == "" ? "Name" : _project.title![0],
              style: const TextStyle(fontSize: 60),
            ),
          ),
          radius: 100.0,
        ),
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
              initialValue: _project.title,
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
                _project.title = value;
                return null;
              },
            ),
            const Divider(thickness: 1, height: 20, color: Colors.white),
            TextFormField(
              initialValue: _project.description,
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
                _project.description = value;
                return null;
              },
            ),
            const Divider(thickness: 1, height: 20, color: Colors.white),
            TextFormField(
              initialValue: _project.image,
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
                _project.image = value;
                return null;
              },
            ),
            GFButton(
              text: "Create",
              color: GFColors.PRIMARY,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var res = await _projectService.createGroupProject(
                    groupId: screenArgv.groupId,
                    project: _project,
                  );
                  if (res) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Create project successful')),
                    );
                    Navigator.of(context).pushNamed(
                      Routes.projects,
                      arguments: ProjectsScreenArguments(
                        roleId: screenArgv.roleId,
                        groupId: screenArgv.groupId,
                        roleName: screenArgv.roleName,
                        rights: screenArgv.rights,
                        members: screenArgv.members,
                      ),
                    );
                  } else if (!res) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Create project failed')),
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
                    // _buildProfileForm(user: user),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.all(50),
                child: Center(
                  child: Image.asset('assets/images/project.png'),
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
        as ProjectCreateScreenArguments;

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
