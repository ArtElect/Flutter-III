import 'package:flutter/material.dart';
import 'package:client/constant/my_colors.dart';
import 'package:getwidget/getwidget.dart';

Widget activeProjectsCard() {
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
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 0),
            leading: const GFAvatar(),
            title: const Text(
              'Project A',
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing',
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.more_vert),
            onTap: () => {},
          ),
        ],
      ),
      buttonBar: GFButtonBar(
        // textDirection: TextDirection.ltr,
        // alignment: WrapAlignment.end,
        // runAlignment: WrapAlignment.end,
        // crossAxisAlignment: WrapCrossAlignment.end,
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
      ),
    );

}
