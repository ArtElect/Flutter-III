import 'package:flutter/material.dart';

class UnauthorizedBody extends StatelessWidget {
  const UnauthorizedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/images/unauthorized.png'),
    );
  }
}
