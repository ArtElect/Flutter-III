import 'package:flutter/material.dart';
import 'package:client/constant/my_colors.dart';
import 'package:getwidget/getwidget.dart';

class GroupCard extends StatelessWidget {
  final String name;
  final String role;
  final String description;
  const GroupCard({
    Key? key,
    required this.name,
    required this.role,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 120,
      padding: const EdgeInsets.all(0),
      child: GFCard(
        boxFit: BoxFit.cover,
        titlePosition: GFPosition.start,
        margin: const EdgeInsets.all(0),
        title: GFListTile(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.symmetric(vertical: 5),
          title: Text(
            name,
            style: const TextStyle(
              color: MyColors.text,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subTitle: Text(
            'Participates as a $role',
            style: const TextStyle(
              color: MyColors.text,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        content: Text(
          description,
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: MyColors.text,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        // buttonBar: GFButtonBar(
        //   children: <Widget>[
        //     GFButton(
        //       onPressed: () {},
        //       text: 'Buy',
        //     ),
        //     GFButton(
        //       onPressed: () {},
        //       text: 'Cancel',
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
