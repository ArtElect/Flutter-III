class Member {
  final String name;
  final String url;

  Member({required this.name, required this.url});
  static List<Member> getMembers() {
    return <Member>[
      Member(
          name: "Zhiwen Wang",
          url:
              "https://gravatar.com/avatar/231ed37a5279342e69c310a40e6d905f?s=400&d=robohash&r=x"),
      Member(
          name: "Sacha Dubois",
          url:
              "https://gravatar.com/avatar/588c3d59c4a061ab3dc212c980dd172c?s=400&d=robohash&r=x"),
    ];
  }
}