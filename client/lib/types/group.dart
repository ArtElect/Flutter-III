import 'package:client/types/member.dart';

class Group {
  final String url;
  final String name;
  final String description;
  final List<Member> members;

  Group({
    required this.name,
    required this.url,
    required this.description,
    required this.members,
  });
  static List<Group> getGroups() {
    return <Group>[
      Group(
        name: "Admin",
        url:
            "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        members: Member.getMembers(),
      ),
      Group(
        name: "Manager",
        url:
            "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        members: Member.getMembers(),
      ),
      Group(
        name: "Worker",
        url:
            "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        members: Member.getMembers(),
      ),
      Group(
        name: "Teacher",
        url:
            "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        members: Member.getMembers(),
      ),
      Group(
        name: "Student",
        url:
            "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        members: Member.getMembers(),
      ),
      Group(
        name: "Visitor",
        url:
            "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        members: Member.getMembers(),
      ),
    ];
  }
}
