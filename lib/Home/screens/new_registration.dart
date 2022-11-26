import 'package:flutter/material.dart';

class NewRegistration extends StatelessWidget {
  const NewRegistration({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text('NewRegistration'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.upload_file_outlined),
        ));
  }
}
