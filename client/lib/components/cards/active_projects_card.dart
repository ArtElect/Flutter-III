import 'package:flutter/material.dart';
import 'package:client/constant/my_colors.dart';
import 'package:getwidget/getwidget.dart';
import 'package:client/models/project_model.dart';
import 'package:client/components/empty/empty_card.dart';

class ActiveProjectsCard extends StatelessWidget {
  final List<ProjectModel> projects;
  const ActiveProjectsCard({Key? key, required this.projects})
      : super(key: key);

  List<Widget> _buildProjectTile() {
    List<Widget> childs = [];

    for (var i = 0; i < projects.length; i++) {
      childs.add(
        ListTile(
          contentPadding: const EdgeInsets.only(left: 0),
          leading: const GFAvatar(),
          title: Text(
            projects[i].title!,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            projects[i].description!,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(Icons.more_vert),
          onTap: () => {},
        ),
      );
    }
    return childs;
  }

  Widget _buildContent() {
    if (projects.isEmpty) {
      return const EmptyCard(str: "No active projects have been found");
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ..._buildProjectTile(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GFCard(
      boxFit: BoxFit.cover,
      titlePosition: GFPosition.start,
      margin: const EdgeInsets.all(0),
      title: const GFListTile(
        margin: EdgeInsets.all(0),
        title: Text(
          'Active projects',
          style: TextStyle(
            color: MyColors.text,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
      ),
      content: _buildContent(),
      buttonBar: projects.isNotEmpty
          ? GFButtonBar(
              children: <Widget>[
                GFButton(
                  onPressed: () {},
                  text: 'See more',
                  type: GFButtonType.transparent,
                  focusElevation: 0,
                  hoverElevation: 0,
                  highlightElevation: 0,
                  hoverColor: Colors.white,
                  focusColor: Colors.white,
                  position: GFPosition.end,
                ),
              ],
            )
          : null,
    );
  }
}
