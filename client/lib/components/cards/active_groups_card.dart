import 'package:flutter/material.dart';
import 'package:client/constant/my_colors.dart';
import 'package:getwidget/getwidget.dart';
import 'package:client/components/cards/group_card.dart';

class ActiveGroupsCard extends StatelessWidget {
  const ActiveGroupsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFCard(
      boxFit: BoxFit.cover,
      titlePosition: GFPosition.start,
      margin: const EdgeInsets.all(0),
      title: const GFListTile(
        margin: EdgeInsets.all(0),
        title: Text(
          'Active groups',
          style: TextStyle(
            color: MyColors.text,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(
            child: GroupCard(
              name: "Admin",
              role: "Admin",
              description: "Admin group with all basic admin rights",
            ),
          ),
          SizedBox(width: 20, height: 20),
          Expanded(
            child: GroupCard(
              name: "Manager",
              role: "Manager",
              description: "Manager group with all basic manager rights",
            ),
          ),
          SizedBox(width: 20, height: 20),
          Expanded(
            child: GroupCard(
              name: "User",
              role: "User",
              description: "User group with only read right on assign project",
            ),
          ),
        ],
      ),
      buttonBar: GFButtonBar(
        children: <Widget>[
          GFButton(
            onPressed: () {},
            text: 'See more',
          ),
        ],
      ),
    );
  }
}
