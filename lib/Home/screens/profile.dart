import 'package:fair_app/shared/const.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String username;
  const Profile({Key? key, required this.username}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
      ),
      body: Center(
        child: Text(
          "Hoşgeldiniz $username",
          style:
              Theme.of(context).textTheme.headline5?.copyWith(color: kcblack54),
        ),
      ),
    );
  }
}
