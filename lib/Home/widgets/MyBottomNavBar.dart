import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    Key? key,
  }) : super(key: key);
  final int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomCubit(selectedIndex: selectedIndex),
      child: BlocConsumer<BottomCubit, int?>(
        listener: (context, state) {},
        builder: (context, state) {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.text_snippet_rounded),
                label: "Yeni Kayıt",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded), label: "Profil")
            ],
            currentIndex: context.read<BottomCubit>().selectedIndex,
            onTap: context.read<BottomCubit>().ontap,
          );
        },
      ),
    );
  }
}

class BottomCubit extends Cubit<int?> {
  int selectedIndex;

  void ontap(int index) {
    selectedIndex = index;
    emit(selectedIndex);
  }

  BottomCubit({required this.selectedIndex}) : super(0);
}
