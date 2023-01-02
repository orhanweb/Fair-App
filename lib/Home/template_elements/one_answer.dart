import 'package:fair_app/Home/homespecialWidgets/custom_dialog.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/shared/helpers.widget.dart';
import 'package:flutter/material.dart';

class OneAnswer extends StatefulWidget {
  const OneAnswer({super.key});

  @override
  State<OneAnswer> createState() => _OneAnswerState();
}

class _OneAnswerState extends State<OneAnswer> {
  final TextEditingController controller = TextEditingController();
  List<Widget> options = [];
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
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: "Sorunuz?"),
              minLines: 1,
              maxLines: 2,
            ),
          ),
          const SizedBox(height: 5),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ChoiceWidget(
                  width: width,
                  height: height,
                  choiceText:
                      "dfsdlşkgsdfl sdlşfkdlşklşf kdslşf klşdsfgl kdflşgk"),
              ElevatedButton(
                onPressed: () =>
                    showDialog(context: context, builder: mycustomDialog),
                style: ElevatedButton.styleFrom(
                    backgroundColor: kcwhite54, foregroundColor: kcCuriousBlue),
                child: const Text("+ Add Option"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ChoiceWidget extends StatelessWidget {
  const ChoiceWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.choiceText,
  }) : super(key: key);

  final double width;
  final double height;
  final String choiceText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      width: width * 0.8,
      height: height * 0.05,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.amber,
          borderRadius: BorderRadius.circular(20)),
      child: InkWell(
          onTap: () {
            print("object");
          },
          highlightColor: Colors.amber,
          child: Text(
            choiceText,
            style: Theme.of(context).textTheme.bodySmall,
          )),
    );
  }
}
