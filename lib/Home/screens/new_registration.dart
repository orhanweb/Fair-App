import 'package:fair_app/auth/screens/my_auth_layout.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class NewRegistration extends StatelessWidget {
  const NewRegistration({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    Get.to(MyAuthLayout());
                  },
                  child: Text("Çıkış Yap")),
              Text('NewRegistration'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.upload_file_outlined),
        ));
  }
}
