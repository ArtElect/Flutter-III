import 'package:flutter/material.dart';

class RoleTextField extends StatelessWidget {
  final String label;
  final String errorMessage;
  final TextEditingController controller;

  const RoleTextField({
    Key? key,
    required this.label,
    required this.errorMessage,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        SizedBox(
          width: 300,
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) return errorMessage;
              return null;
            },
            decoration: InputDecoration(
              labelText: label,
              hintText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}