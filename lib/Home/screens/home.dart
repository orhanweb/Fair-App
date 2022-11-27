import 'package:fair_app/Home/screens/new_registration.dart';
import 'package:fair_app/Home/screens/profile.dart';

import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key, required this.username}) : super(key: key);
  final int selectedIndex = 0;
  final String username;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text("Fuar Anasayfa"),
              bottom: const TabBar(
                tabs: [
                  Tab(text: "Yeni Kayıt"),
                  Tab(text: "Kaydedilenler"),
                  Tab(text: "Profil"),
                ],
              )),
          body: TabBarView(children: [
            const NewRegistration(),
            Container(color: Colors.yellow),
            Profile(username: username)
          ]),
        ));
  }
}
