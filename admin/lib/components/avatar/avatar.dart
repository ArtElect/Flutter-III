import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String username;

  const Avatar({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 40, height: 40),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(username[0]),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10),
          // primary: Colors.blue, // <-- Button color
          // onPrimary: Colors.red, // <-- Splash color
        ),
      ),
    );
  }
}
