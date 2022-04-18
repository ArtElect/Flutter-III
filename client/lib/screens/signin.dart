import 'package:flutter/material.dart';

import 'package:client/constant/my_colors.dart';

import 'package:client/components/navbar/navbar.dart';
import 'package:client/components/cards/signin_card.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Navbar(),
      body: Content(),
    );
  }
}

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color : MyColors.background,
      child : const Center(
        child: SignInCard(),
      ),
    );
  }
}

