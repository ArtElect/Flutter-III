import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String placeholder;
  const TextInput({Key? key, required this.placeholder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: placeholder,
      ),
      maxLines: 1,
    );
  }
}
