import 'package:fair_app/Home/homespecialWidgets/no_data_column.dart';

import 'package:flutter/material.dart';

class Archives extends StatelessWidget {
  const Archives({Key? key}) : super(key: key);

  //Local Variables
  final String noRegImage = "assets/images/file-and-folder.png";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: NoDataColumn(
      height: height,
      width: width,
      nolistimagePath: noRegImage,
      text: "Hiç kayıt oluşturulmamış",
    ));
  }
}
