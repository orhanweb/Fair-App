import 'package:fair_app/shared/const.dart';
import 'package:fair_app/shared/helpers.widget.dart';
import 'package:flutter/material.dart';

class Archives extends StatelessWidget {
  const Archives({Key? key}) : super(key: key);

  //Local Variables
  final String noRegImage = "assets/images/file-and-folder.png";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              width: width * 0.7,
              noRegImage,
              fit: BoxFit.contain,
            ),
          ),
          verticalSpaceTiny,
          Text(
            "Hiç kayıt oluşturulmamış",
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: kcblack54),
          ),
        ],
      ),
    );
  }
}
