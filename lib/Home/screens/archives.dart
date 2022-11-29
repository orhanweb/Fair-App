import 'package:flutter/material.dart';

class Archives extends StatelessWidget {
  const Archives({Key? key}) : super(key: key);

  @override
  void initState() {
    print("Arşivle");
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Archives'),
      ),
    );
  }
}
