import 'package:dotted_border/dotted_border.dart';
import 'package:fair_app/shared/const.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CameraElements extends StatefulWidget {
  const CameraElements({super.key, this.onTapUse = false});
  final bool onTapUse;

  @override
  State<CameraElements> createState() => _CameraElementsState();
}

class _CameraElementsState extends State<CameraElements> {
  File? _image;

  Future _pickImage(ImageSource source) async {
    final _image = await ImagePicker().pickImage(source: source);
    if (_image == null) {
      print("Image Boş ");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.1,
      height: height * 0.28,
      child: DottedBorder(
        strokeCap: StrokeCap.round,
        radius: const Radius.circular(20),
        dashPattern: const [10, 15],
        color: kcParisGreen,
        borderPadding: const EdgeInsets.all(10),
        borderType: BorderType.RRect,
        strokeWidth: 5,
        child: InkWell(
          onTap: widget.onTapUse ? null : null,
          child: Container(
              margin: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: kcParisGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                  child: Icon(
                Icons.photo_camera,
                size: 30,
              ))),
        ),
      ),
    );
  }
}
