import 'package:flutter/material.dart';
import 'package:client/constant/my_colors.dart';
import 'package:client/components/cards/project_card.dart';

class ActiveProjectCard extends StatelessWidget {
  const ActiveProjectCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      width: 1000,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Header(),
              Body(),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 1,
      child: Text(
        "Active Projects",
        style: TextStyle(
          fontSize: 16,
          color: MyColors.text,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          ProjectCard(),
          ProjectCard(),
        ],
      ),
    );
  }
}
