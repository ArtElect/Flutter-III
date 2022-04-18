import 'package:flutter/material.dart';
import 'package:client/constant/my_colors.dart';
import 'package:getwidget/getwidget.dart';

class TextBox extends StatelessWidget {
  final String name;
  final String label;
  const TextBox({
    Key? key,
    required this.name,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(color: MyColors.subtext, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            // style: const TextStyle(color: MyColors.subtext, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
