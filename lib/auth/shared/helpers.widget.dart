import 'package:flutter/material.dart';

//HORIZONTAL SPACERS
class HorizontalSpacers extends StatelessWidget {
  final double boyut;
  const HorizontalSpacers({super.key, required this.boyut});

  @override
  Widget build(BuildContext context) {
    final Size fairSize = MediaQuery.of(context).size;
    return SizedBox(
      width: fairSize.width * boyut,
    );
  }
}

Widget horizontalSpaceTiny = const HorizontalSpacers(boyut: 0.1);
Widget horizontalSpaceSmall = const HorizontalSpacers(boyut: 0.2);
Widget horizontalSpaceRegular = const HorizontalSpacers(boyut: 0.3);
Widget horizontalSpaceMedium = const HorizontalSpacers(boyut: 0.4);
Widget horizontalSpaceLarge = const HorizontalSpacers(boyut: 0.7);

// VERTICAL SPACERS

class VerticalSpacers extends StatelessWidget {
  final double boyut;
  final Color color;
  final String text;
  const VerticalSpacers(
      {super.key,
      required this.boyut,
      required this.color,
      required this.text});

  @override
  Widget build(BuildContext context) {
    final Size fairSize = MediaQuery.of(context).size;
    return SizedBox(
      width: fairSize.width * boyut,
      child: Container(
        color: color,
        child: Text(text),
      ),
    );
  }
}

Widget verticalSpaceTiny = const VerticalSpacers(
  boyut: 0.05,
  color: Colors.amberAccent,
  text: "verticalSpaceTiny",
);
Widget verticalSpaceSmall = const VerticalSpacers(
  boyut: 0.08,
  color: Colors.grey,
  text: "verticalSpaceSmall",
);
Widget verticalSpaceRegular = const VerticalSpacers(
  boyut: 0.15,
  color: Colors.blueAccent,
  text: "verticalSpaceRegular",
);
Widget verticalSpaceMedium = const VerticalSpacers(
  boyut: 0.25,
  color: Colors.orange,
  text: "verticalSpacemedium",
);
Widget verticalSpaceLarge = const VerticalSpacers(
  boyut: 0.6,
  color: Colors.lightBlueAccent,
  text: "verticalSpaceLarge",
);
