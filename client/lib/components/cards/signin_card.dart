import 'package:flutter/material.dart';
import 'package:client/routes/routes.dart';
import 'package:client/constant/my_colors.dart';
import 'package:client/components/inputs/text_input.dart';

class SignInCard extends StatefulWidget {
  const SignInCard({Key? key}) : super(key: key);

  @override
  State<SignInCard> createState() => _SignInCardState();
}

class _SignInCardState extends State<SignInCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: 400,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: const [
            Header(),
            Body(),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 1,
      child: Center(
        child: Text(
          "Epitech Dashboard",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: MyColors.purple,
          ),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            TextInput(placeholder: "Email"),
            TextInput(placeholder: "Password")
          ],
        ),
      ),
    );
  }
}

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: SizedBox(
          height: 50,
          width: 350,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: MyColors.purple),
            child: const Text("Sign In"),
            onPressed: () => {Navigator.of(context).pushNamed(Routes.home)},
          ),
        ),
      ),
    );
  }
}
