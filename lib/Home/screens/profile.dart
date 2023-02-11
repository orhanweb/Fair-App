import 'package:fair_app/Core/Constants/const.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String username;
  const Profile({Key? key, required this.username}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
      body: Center(
        child: Text(
          "Hoşgeldiniz $username",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: kcblack54),
        ),
      ),
    );
  }
}
