import 'package:flutter/material.dart';
import 'package:client/constant/my_colors.dart';
import 'package:client/components/cards/group_card.dart';

Widget activeGroupsCard() {
  final List<String> imageList = [
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
  ];
  final List<String> entries = <String>[
    'Admin',
    'Manager',
    'Worker',
    'Teacher',
    'Student',
    'Visitor',
  ];

  const String lorem =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";

  return Container(
    color: Colors.white,
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    height: 250,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Active groups',
          style: TextStyle(
            color: MyColors.text,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 12),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: entries.length,
              separatorBuilder: (a, b) => const SizedBox(width: 10),
              itemBuilder: (BuildContext context, int index) {
                return groupCard(
                  image: imageList[index],
                  name: entries[index],
                  description: lorem,
                  onTap: () => {debugPrint('Tap on: $index')},
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}
