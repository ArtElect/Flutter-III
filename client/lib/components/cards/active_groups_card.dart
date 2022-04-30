import 'package:client/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:client/constant/my_colors.dart';
import 'package:client/components/cards/group_card.dart';
// import 'package:client/types/group.dart';
import 'package:client/screens/web/project/big_projects.dart';
import 'package:client/models/role_model.dart';
import 'package:client/components/empty/empty_card.dart';

class ActiveGroupsCard extends StatelessWidget {
  // final List<Group> groups;
  final List<RoleModel> roles;
  const ActiveGroupsCard({Key? key, required this.roles}) : super(key: key);

  Widget _buildContent() {
    if (roles.isEmpty) {
      return const Expanded(
        child: EmptyCard(str: "No group has been assigned to you"),
      );
    }
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: roles.length,
      separatorBuilder: (a, b) => const SizedBox(width: 10),
      itemBuilder: (BuildContext context, int index) {
        return GroupCard(
          image:
              "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
          name: roles[index].group.name,
          description: roles[index].group.description!,
          onTap: () => {
            Navigator.of(context).pushNamed(
              Routes.projects,
              arguments: ProjectsScreenArguments(
                groupId: roles[index].id,
                roleName: roles[index].name,
                members: roles[index].users,
                rights: roles[index].rights
              ),
            ),
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Active groups',
            style: TextStyle(
              color: MyColors.text,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              child: _buildContent(),
            ),
          ),
        ],
      ),
    );
  }
}
