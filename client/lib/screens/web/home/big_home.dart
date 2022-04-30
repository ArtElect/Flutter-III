import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:client/components/navbar/navbar.dart';
import 'package:client/components/sidebar/sidebar.dart';

import 'package:client/components/cards/active_groups_card.dart';
import 'package:client/components/cards/active_projects_card.dart';
import 'package:client/components/cards/project_progression_card.dart';
import 'package:client/components/cards/role_members_card.dart';
import 'package:client/components/unauthorized/unauthorized.dart';
import 'package:client/components/empty/empty_card.dart';

import 'package:client/types/member.dart';
import 'package:client/types/group.dart';

import 'package:client/models/group_projects_model.dart';
import 'package:client/models/project_model.dart';

import 'package:client/models/role_model.dart';
import 'package:client/services/role.dart';

import 'package:client/constant/my_colors.dart';
import 'dart:math';

class BigHomePage extends StatefulWidget {
  const BigHomePage({Key? key}) : super(key: key);

  @override
  _BigHomePageState createState() => _BigHomePageState();
}

class _BigHomePageState extends State<BigHomePage> {
  final _random = Random();

  final RoleService _roleService = RoleService();

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

  Widget projectCarousel({required List<ProjectModel> projects}) {
    if (projects.isEmpty) {
      return const EmptyCard(str: "No project avaible");
    }
    return CarouselSlider.builder(
      itemCount: projects.length,
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration:
            const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      itemBuilder: (
        BuildContext context,
        int index,
        int pageViewIndex,
      ) =>
          ProjectProgressionCard(
              name: projects[index].title!, progression: _random.nextInt(100).toDouble(), numberOfMembers: 15),
    );
  }

  Widget roleCarousel({required List<RoleModel> roles}) {
    if (roles.isEmpty) {
      return const EmptyCard(str: "No role avaible");
    }

    return CarouselSlider.builder(
      itemCount: roles.length,
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration:
            const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      itemBuilder: (
        BuildContext context,
        int index,
        int pageViewIndex,
      ) =>
          RoleMembersCard(
              name: roles[index].name, members: roles[index].users),
    );
  }

  Widget _buildContent(List<RoleModel> roles) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 30,
        ),
        height: double.infinity,
        color: MyColors.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            welcome(name: "Zhiwen"),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    // Left side
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ActiveGroupsCard(roles: roles),
                          const SizedBox(width: 20, height: 20),
                          Expanded(
                            child: ActiveProjectsCard(projects: _roleService.activeProjects),
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
                          Expanded(child: roleCarousel(roles: roles)),
                          const Divider(
                              thickness: 5, color: MyColors.background),
                          Expanded(child: projectCarousel(projects: _roleService.activeProjects)),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(),
      body: Row(
        children: [
          const Sidebar(selectedIndex: 0),
          FutureBuilder<List<RoleModel>>(
            future: _roleService.getRoles(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return _buildContent(snapshot.data!);
              } else {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
