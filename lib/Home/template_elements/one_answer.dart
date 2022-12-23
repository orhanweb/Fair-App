import 'package:fair_app/shared/const.dart';
import 'package:flutter/material.dart';

class OneAnswer extends StatelessWidget {
  OneAnswer({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: kcCuriousBlue,
          borderRadius: BorderRadius.circular(20)),
      height: height * 0.2,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: "Sorunuz?"),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kcwhite54,
                      foregroundColor: kcCuriousBlue),
                  child: const Text("+ Add Option"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
