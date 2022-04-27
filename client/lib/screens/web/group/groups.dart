import 'package:client/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:client/components/navbar/navbar.dart';
import 'package:client/components/sidebar/sidebar.dart';
import 'package:client/components/cards/group_card.dart';
import 'package:client/components/unauthorized/unauthorized.dart';

import 'package:client/models/role_model.dart';

import 'package:client/services/role.dart';
import 'package:client/constant/my_colors.dart';
import 'package:client/screens/web/project/projects.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final RoleService _roleService = RoleService();

  Widget _buildHeader() {
    return const Text(
      "List of groups",
      style: TextStyle(
        color: MyColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    );
  }

  Widget _buildContent(List<RoleModel> groups) {
    if (groups.isEmpty) {
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
            _buildHeader(),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemCount: groups.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GroupCard(
                      image:
                          "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
                      name: groups[index].group.name!,
                      description: groups[index].group.description!,
                      onTap: () => {
                        Navigator.of(context).pushNamed(
                          Routes.projects,
                          arguments: ProjectsScreenArguments(
                            groupId: groups[index].id,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(),
      body: Row(
        children: [
          const Sidebar(selectedIndex: 1),
          FutureBuilder<List<RoleModel>>(
            future: _roleService.getRoles(),
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
