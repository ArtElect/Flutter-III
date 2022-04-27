import 'package:client/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:client/constant/my_colors.dart';
import 'package:client/components/cards/group_card.dart';
// import 'package:client/types/group.dart';
import 'package:client/screens/web/project/projects.dart';
import 'package:client/models/group_projects_model.dart';

class ActiveGroupsCard extends StatelessWidget {
  // final List<Group> groups;
  final List<GroupProjectsModel> groups;
  const ActiveGroupsCard({Key? key, required this.groups}) : super(key: key);

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
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: groups.length,
                separatorBuilder: (a, b) => const SizedBox(width: 10),
                itemBuilder: (BuildContext context, int index) {
                  return GroupCard(
                    image: "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
                    name: groups[index].group.name!,
                    description: groups[index].group.description!,
                    onTap: () => {
                      Navigator.of(context).pushNamed(Routes.projects, arguments: ProjectsScreenArguments(groupId: groups[index].id))

                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('On Tap ${groups[index].group.name}'),
                      //     action: SnackBarAction(
                      //       label: 'Undo',
                      //       onPressed: () {
                      //         // Some code to undo the change.
                      //       },
                      //     ),
                      //   ),
                      // ),
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
