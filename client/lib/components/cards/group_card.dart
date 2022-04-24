import 'package:flutter/material.dart';

Widget groupCard({
  required String image,
  required String name,
  required String description,
  required GestureTapCallback onTap,
}) {
  return Container(
    height: 180,
    width: 250,
    decoration: BoxDecoration(
      image: DecorationImage(
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.5),
          BlendMode.darken,
        ),
        image: NetworkImage(image),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 24,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            description,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}
