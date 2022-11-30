import 'package:fair_app/Home/homespecialWidgets/sliver_app_bar.dart';
import 'package:fair_app/Home/screens/archives.dart';
import 'package:fair_app/Home/screens/new_registration.dart';

import 'package:flutter/material.dart';

import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key, required this.username}) : super(key: key);
  final int selectedIndex = 0;
  final String username;
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;

    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      // KEYBOARD CONTROLS
      return KeyboardDismisser(
        gestures: const [GestureType.onPanCancel],
        //TABBAR AND PAGES
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    MySliverAppbar(
                      username: username,
                    ),
                  ];
                },
                body: TabBarView(children: [
                  NewRegistration(isKeyboardVisible: isKeyboardVisible),
                  const Archives(),
                ]),
              ),
            )),
      );
    });
  }
}
