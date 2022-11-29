import 'package:fair_app/shared/helpers.widget.dart';
import 'package:fair_app/widgets/top_text_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            color: Colors.amber,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      color: Color.fromARGB(255, 126, 49, 26),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_back_ios_rounded))),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Colors.white,
                        child: TopTextWidget(title: "Tekrar Hoşgeldiniz."),
                      ),
                      verticalSpaceSmall,
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
