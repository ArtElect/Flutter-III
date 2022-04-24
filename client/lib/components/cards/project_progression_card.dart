import 'package:flutter/material.dart';
import 'package:client/constant/my_colors.dart';
import 'package:getwidget/getwidget.dart';
import 'package:percent_indicator/percent_indicator.dart';

Widget projectProgressionCard({required String name}) {
  return GFCard(
    boxFit: BoxFit.cover,
    titlePosition: GFPosition.start,
    margin: const EdgeInsets.all(0),
    title: const GFListTile(
      margin: EdgeInsets.all(0),
      title: Text(
        'Project overview',
        style: TextStyle(
          color: MyColors.text,
          fontWeight: FontWeight.w900,
          fontSize: 18,
        ),
      ),
    ),
    content: Center(
      child: CircularPercentIndicator(
        radius: 200.0,
        lineWidth: 20.0,
        percent: 0.8,
        circularStrokeCap: CircularStrokeCap.round,
        backgroundColor: MyColors.grey,
        progressColor: MyColors.purple,
        header: const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 15),
          child: Text(
            "Project A",
            style: TextStyle(
              color: MyColors.text,
              fontWeight: FontWeight.w900,
              fontSize: 24,
            ),
          ),
        ),
        center: const Text(
          "50%",
          style: TextStyle(
            color: MyColors.text,
            fontWeight: FontWeight.w900,
            fontSize: 24,
          ),
        ),
        footer: const Padding(
          padding: EdgeInsets.only(top: 15, bottom: 10),
          child: Text(
            "16 members",
            style: TextStyle(
              color: MyColors.grey,
              fontWeight: FontWeight.w900,
              fontSize: 14,
            ),
          ),
        ),
      ),
    ),
  );
}
