import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:client/constant/my_colors.dart';

class Member {
  final String name;
  final String url;

  Member({required this.name, required this.url});
  static List<Member> getMembers() {
    return <Member>[
      Member(name: "Zhiwen Wang", url: "https://gravatar.com/avatar/231ed37a5279342e69c310a40e6d905f?s=400&d=robohash&r=x"),
      Member(name: "Sacha Dubois", url: "https://gravatar.com/avatar/588c3d59c4a061ab3dc212c980dd172c?s=400&d=robohash&r=x"),
    ];
  }
}

Widget groupMembersCard() {
  String name = "Admin";
  List<Member> listOfMembers = Member.getMembers();

  List<Widget> getList() {
    List<Widget> childs = [];
    for (var i = 0; i < listOfMembers.length; i++) {
      childs.add(
        ListTile(
          contentPadding: const EdgeInsets.only(left: 0, right: 0),
          leading: GFAvatar(
            backgroundImage: NetworkImage(listOfMembers[i].url),
          ),
          title: Text(
            listOfMembers[i].name,
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
          '${listOfMembers.length} members',
          style: const TextStyle(
            color: MyColors.grey,
            fontSize: 14,
          ),
        ),
      ),
    ),
    content: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...getList()
      ],
    ),
  );
}
