import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String username;
  const Profile({Key? key, required this.username}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(username),
      ),
    );
  }
}
