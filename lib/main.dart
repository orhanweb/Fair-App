import 'package:fair_app/Home/models/home_templates_cubit.dart';
import 'package:fair_app/Home/models/home_newreg_model.dart';
import 'package:fair_app/Home/screens/home.dart';

import 'package:fair_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grock/grock.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  NewRegCubit(textfieldListwithControllers: [])),
          BlocProvider(create: (context) => CardListCubit())
        ],
        child: MaterialApp(
            navigatorKey: Grock.navigationKey,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(),
            home: const HomeView(username: "admin")));
  }
}
