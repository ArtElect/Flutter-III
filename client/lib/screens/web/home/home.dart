import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:client/components/navbar/navbar.dart';
import 'package:client/components/sidebar/sidebar.dart';

import 'package:client/components/cards/active_groups_card.dart';
import 'package:client/components/cards/active_projects_card.dart';
import 'package:client/components/cards/project_progression_card.dart';
import 'package:client/components/cards/group_members_card.dart';

import 'package:client/types/member.dart';
import 'package:client/types/group.dart';

import 'package:client/constant/my_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Group> groups = Group.getGroups();
  List<Member> listOfMembers = Member.getMembers();


  Widget welcome({required String name}) {
    return Text(
      "Welcome $name",
      style: const TextStyle(
        color: MyColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    );
  }

  Widget projectCarousel() {
    return CarouselSlider.builder(
      itemCount: 2,
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        // autoPlay: true,
        // autoPlayInterval: Duration(seconds: 3),
        // autoPlayAnimationDuration:
        //     Duration(milliseconds: 800),
        // autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      itemBuilder: (
        BuildContext context,
        int index,
        int pageViewIndex,
      ) =>
          const ProjectProgressionCard(name: "Project A", progression: 50, numberOfMembers: 15),
    );
  }

  Widget groupCarousel() {
    return CarouselSlider.builder(
      itemCount: groups.length,
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        // autoPlay: true,
        // autoPlayInterval: Duration(seconds: 3),
        // autoPlayAnimationDuration:
        //     Duration(milliseconds: 800),
        // autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      itemBuilder: (
        BuildContext context,
        int index,
        int pageViewIndex,
      ) =>
          GroupMembersCard(name: groups[index].name, members: groups[index].members),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(),
      body: Row(
        children: [
          const Sidebar(selectedIndex: 0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              height: double.infinity,
              color: MyColors.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  welcome(name: "Zhiwen"),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          // Left side
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ActiveGroupsCard(groups: groups),
                                const SizedBox(width: 20, height: 20),
                                const Expanded(
                                  child: ActiveProjectsCard(),
                                )
                              ],
                            ),
                          ),

                          // Right side
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            width: 350,
                            // color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: groupCarousel()),
                                const Divider(
                                    thickness: 5, color: MyColors.background),
                                Expanded(child: projectCarousel()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
