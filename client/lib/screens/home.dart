import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:client/components/navbar/navbar.dart';
import 'package:client/components/cards/active_groups_card.dart';
import 'package:client/constant/my_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Views to display

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      height: double.infinity,
      color: MyColors.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Header(name: "Zhiwen"),
          Body(),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String name;
  const Header({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Welcome $name",
      style: const TextStyle(
        color: MyColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            height: 250,
            // child: Container(
            //   color: MyColors.purple,
            // ),
            child: const ActiveGroupsCard(),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            height: 350,
            child: Container(
              color: MyColors.purple,
            ),
            // child: ActiveGroupsCard(),
          ),
        ],
      ),
    );
  }
}
