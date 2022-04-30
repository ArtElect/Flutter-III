import 'package:flutter/material.dart';
import 'package:client/constant/my_colors.dart';

class EmptyCard extends StatelessWidget {
  final String str;
  const EmptyCard({Key? key, required this.str}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          str,
          style: const TextStyle(
            color: MyColors.text,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
