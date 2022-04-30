import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:client/constant/my_colors.dart';
import 'package:client/models/user_model.dart';

class RoleMembersCard extends StatelessWidget {
  final String name;
  final List<UserModel> members;

  const RoleMembersCard({
    Key? key,
    required this.name,
    required this.members,
  }) : super(key: key);

  List<Widget> getListOfMembers() {
    List<Widget> childs = [];
    const max = 4;
    for (var i = 0; i < members.length && i <= max; i++) {
      childs.add(
        ListTile(
          contentPadding: const EdgeInsets.only(left: 0, right: 0),
          leading: members[i].image != "" ? GFAvatar(
            backgroundImage: NetworkImage(members[i].image!),
          ) : GFAvatar(
            child: Center(child: Text(members[i].firstName[0])),
          ),
          title: Text(
            members[i].firstName + ' ' + members[i].lastName,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            'Role : ${members[i].role}',
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(Icons.visibility_outlined),
          onTap: () => {},
        ),
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
