import 'package:fair_app/shared/const.dart';
import 'package:flutter/material.dart';

class MySliverAppbar extends StatelessWidget {
  const MySliverAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        title: const Text("Fuar Anasayfa"),
        scrolledUnderElevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings_sharp))
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
          ],
        ));
  }
}
