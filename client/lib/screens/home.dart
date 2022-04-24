import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:client/components/navbar/navbar.dart';
import 'package:client/components/sidebar/sidebar.dart';

import 'package:client/components/cards/active_groups_card.dart';
import 'package:client/components/cards/active_projects_card.dart';
import 'package:client/components/cards/project_progression_card.dart';
import 'package:client/components/cards/group_members_card.dart';
import 'package:client/constant/my_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Views to display
  List<String> imageList = [
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
  ];

  List<Object> groupList = [
    {
      "name": "Admin",
      "members": [
        {
          "avatar_url":
              "https://gravatar.com/avatar/231ed37a5279342e69c310a40e6d905f?s=400&d=robohash&r=x",
          "name": "Zhiwen Wang"
        },
      ]
    },
    {
      "name": "Développeur",
      "members": [
        {
          "avatar_url":
              "https://gravatar.com/avatar/3ff67eb871a16ba44582711d75d2c460?s=400&d=robohash&r=x",
          "name": "Sacha du Bourg-Palette"
        },
      ]
    },
  ];

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
          projectProgressionCard(name: "Project A"),
    );
  }

  Widget groupCarousel() {
    return CarouselSlider.builder(
      itemCount: groupList.length,
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
          groupMembersCard(),
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
                                activeGroupsCard(),
                                const SizedBox(width: 20, height: 20),
                                Expanded(
                                  child: activeProjectsCard(),
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
