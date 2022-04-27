import 'package:flutter/material.dart';
import 'package:client/constant/my_colors.dart';

class EmptyBody extends StatelessWidget {
  const EmptyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 30,
      ),
      height: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              'Oops it seems that the group has no project yet',
              style: const TextStyle(
                color: MyColors.text,
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
          ),
          Center(child:Image.asset('assets/images/empty.png')),
        ],
      ),
    );
  }
}
