import 'package:fair_app/auth/shared/helpers.widget.dart';
import 'package:flutter/material.dart';

import 'auth/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Title'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceTiny,
              verticalSpaceSmall,
              verticalSpaceRegular,
              verticalSpaceMedium,
              verticalSpaceLarge,
            ],
          ),
        ),
      ),
    );
  }
}
