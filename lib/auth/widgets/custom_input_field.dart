import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    Key? key,
    required this.width,
    this.hint = "None",
    this.passwordfeatures = false,
    required this.prevIcon,
  }) : super(key: key);

  //parameters
  final String hint;
  final double width;
  final bool passwordfeatures;
  final Icon prevIcon;
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
      child: TextField(
        obscureText: _passwordvisibilty,
        decoration: InputDecoration(
          prefixIcon: widget.prevIcon,
          suffixIcon: widget.passwordfeatures
              ? IconButton(
                  onPressed: () {
                    _passwordvisibilty = !(_passwordvisibilty);
                    setState(() {});
                  },
                  icon: _passwordvisibilty
                      ? const Icon(Icons.visibility_outlined)
                      : const Icon(Icons.visibility_off_outlined))
              : null,
          hintText: widget.hint,
          hintStyle: const TextStyle(color: Colors.black54),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.blueAccent,
                style: BorderStyle.solid,
                width: 3,
                strokeAlign: StrokeAlign.center),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black38,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
