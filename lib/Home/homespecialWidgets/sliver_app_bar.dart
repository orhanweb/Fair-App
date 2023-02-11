import 'package:fair_app/Home/screens/profile.dart';
import 'package:fair_app/Core/Constants/const.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

class MySliverAppbar extends StatelessWidget {
  const MySliverAppbar({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        title: const Text("Ekin Anasayfa"),
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Grock.to(Profile(username: username));
              },
              icon: const Icon(Icons.settings_sharp))
        ],
        pinned: true,
        floating: true,
        bottom: const TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          indicator: BoxDecoration(
            shape: BoxShape.rectangle,
            color: kcblack45,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          labelColor: kcwhite,
          unselectedLabelColor: kcwhite54,
          unselectedLabelStyle:
              TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          tabs: [
            Tab(text: "Yeni Kayıt"),
            Tab(text: "Kaydedilenler"),
            Tab(
              text: "Şablonlar",
            )
          ],
        ));
  }
}
