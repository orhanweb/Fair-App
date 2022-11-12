import 'create_or_login_cubit.dart';
import 'package:fair_app/auth/shared/beautification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomText extends StatelessWidget {
  const BottomText({
    Key? key,
    required this.width,
    required this.height,
    required this.title,
    required this.buttonTitle,
  }) : super(key: key);

// Parameters
  final double width;
  final double height;
  final String title;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: kcPrimaryCascadeTwilight, fontWeight: FontWeight.w400),
        ),
        BlocProvider(
          create: (context) => CreateOrLoginCubit(),
          child: TextButton(
            onPressed: () {
              context.read<CreateOrLoginCubit>().changescreen();
            },
            child: Text(
              buttonTitle,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: kcPrimaryCascadeTwilight, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}
