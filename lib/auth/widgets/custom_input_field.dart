import 'package:fair_app/auth/models/login_model.dart';
import 'package:fair_app/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    Key? key,
    required this.width,
    this.hint = "None",
    this.passwordfeatures = false,
    required this.prevIcon,
    this.validator,
    this.controller,
    this.textisEmpty = false,
  }) : super(key: key);

  //parameters
  final bool textisEmpty;
  final String hint;
  final double width;
  final bool passwordfeatures;
  final Icon prevIcon;
  final String Function(String? value)? validator;
  final TextEditingController? controller;
  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _passwordvisibilty = true;

  //Local Variables
  final _persentage = 0.03;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.width * _persentage),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        obscureText: _passwordvisibilty && widget.passwordfeatures,
        decoration: InputDecoration(
          prefixIcon: widget.prevIcon,
          suffixIcon: suffixIconMethod(),
          hintText: widget.hint,
          hintStyle: const TextStyle(color: kcblack54),
          border: myOutlineInputBorder,
          focusedBorder: myOutlineInputBorder,
          focusColor: kcPrimaryCascadeTwilight,
          iconColor: kcPrimaryCascadeTwilight,
          prefixIconColor: kcPrimaryCascadeTwilight,
          suffixIconColor: kcPrimaryCascadeTwilight,
          enabledBorder: myOutlineInputBorder.copyWith(
              borderSide: const BorderSide(color: kcblack38)),
        ),
      ),
    );
  }

  IconButton? suffixIconMethod() {
    return widget.passwordfeatures
        ? IconButton(
            onPressed: () {
              _passwordvisibilty = !(_passwordvisibilty);
              setState(() {});
            },
            icon: _passwordvisibilty
                ? const Icon(Icons.visibility_outlined)
                : const Icon(Icons.visibility_off_outlined))
        : null;
  }
}
