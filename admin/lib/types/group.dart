class Group {
  int id;
  String name;
  int numberOfMembers;

  Group({
    required this.id,
    required this.name,
    required this.numberOfMembers,
  });

  static List<Group> getGroups() {
    return <Group>[
      Group(id: 1, name: "Group 1", numberOfMembers: 1),
      Group(id: 2, name: "Group 2", numberOfMembers: 1),
      Group(id: 3, name: "Group 3", numberOfMembers: 1),
      Group(id: 4, name: "Group 4", numberOfMembers: 1),
    ];
  }
}
