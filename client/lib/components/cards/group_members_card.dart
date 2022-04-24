import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:client/constant/my_colors.dart';
import 'package:client/types/member.dart';

class GroupMembersCard extends StatelessWidget {
  final String name;
  final List<Member> members;

  const GroupMembersCard({
    Key? key,
    required this.name,
    required this.members,
  }) : super(key: key);

    List<Widget> getListOfMembers() {
    List<Widget> childs = [];
    for (var i = 0; i < members.length; i++) {
      childs.add(
        ListTile(
          contentPadding: const EdgeInsets.only(left: 0, right: 0),
          leading: GFAvatar(
            backgroundImage: NetworkImage(members[i].url),
          ),
          title: Text(
            members[i].name,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(Icons.visibility_outlined),
          onTap: () => {},
        ),
      );
      childs.add(
        const Divider(thickness: 1),
      );
    }
    return childs;
  }

  @override
  Widget build(BuildContext context) {
    return GFCard(
      boxFit: BoxFit.cover,
      titlePosition: GFPosition.start,
      margin: const EdgeInsets.all(0),
      title: GFListTile(
        margin: const EdgeInsets.all(0),
        title: Text(
          '$name members',
          style: const TextStyle(
            color: MyColors.text,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        subTitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            '${members.length} members',
            style: const TextStyle(
              color: MyColors.grey,
              fontSize: 14,
            ),
          ),
        ),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [...getListOfMembers()],
      ),
    );
  }
}
