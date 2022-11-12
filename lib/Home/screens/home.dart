import 'package:fair_app/Home/screens/new_registration.dart';
import 'package:fair_app/Home/widgets/MyBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
      ),
      body: BlocListener<BottomCubit, int?>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: Container(),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
