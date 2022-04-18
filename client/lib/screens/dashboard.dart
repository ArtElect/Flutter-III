import 'package:flutter/material.dart';
import 'package:client/constant/my_colors.dart';
import 'package:client/components/navbar/navbar.dart';
import 'package:client/components/sidebar/sidebar.dart';
import 'package:client/components/cards/active_project_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Navbar(),
      drawer: Sidebar(selectedTab: "Dashboard"),
      body: Content(),
    );
  }
}

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        color: MyColors.background,
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Header(name: "Zhiwen"),
              ActiveProjectCard(),
            ],
          ),
        ),
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
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: MyColors.text,
      ),
    );
  }
}
