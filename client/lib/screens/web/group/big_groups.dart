import 'package:client/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:client/components/navbar/navbar.dart';
import 'package:client/components/sidebar/sidebar.dart';
import 'package:client/components/cards/group_card.dart';
import 'package:client/components/unauthorized/unauthorized.dart';
import 'package:client/components/empty/empty_card.dart';

import 'package:client/models/role_model.dart';

import 'package:client/services/role.dart';
import 'package:client/constant/my_colors.dart';
import 'package:client/screens/web/project/big_projects.dart';

class BigGroupsPage extends StatefulWidget {
  const BigGroupsPage({Key? key}) : super(key: key);

  @override
  State<BigGroupsPage> createState() => _BigGroupsPageState();
}

class _BigGroupsPageState extends State<BigGroupsPage> {
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

  Widget _buildContent(List<RoleModel> roles) {
    if (roles.isEmpty) {
      return const Expanded(child: EmptyCard(str: "No group has been assigned to you"));
    }
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 30,
        ),
        height: double.infinity,
        color: Colors.white,
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
                  itemCount: roles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GroupCard(
                      image: roles[index].group.image!,
                      name: roles[index].group.name,
                      description: roles[index].group.description!,
                      onTap: () => {
                        Navigator.of(context).pushNamed(
                          Routes.projects,
                          arguments: ProjectsScreenArguments(
                            roleId: roles[index].id,
                            groupId: roles[index].group.id!,
                            roleName: roles[index].name,
                            members: roles[index].users,
                            rights: roles[index].rights
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
