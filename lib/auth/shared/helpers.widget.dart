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

Widget horizontalSpaceTiny = const HorizontalSpacers(boyut: 0.05);
Widget horizontalSpaceSmall = const HorizontalSpacers(boyut: 0.08);
Widget horizontalSpaceRegular = const HorizontalSpacers(boyut: 0.15);
Widget horizontalSpaceMedium = const HorizontalSpacers(boyut: 0.25);
Widget horizontalSpaceLarge = const HorizontalSpacers(boyut: 0.6);

// VERTICAL SPACERS

class VerticalSpacers extends StatelessWidget {
  final double boyut;
  const VerticalSpacers({super.key, required this.boyut});

  @override
  Widget build(BuildContext context) {
    final Size fairSize = MediaQuery.of(context).size;
    return SizedBox(
      height: fairSize.height * boyut,
    );
  }
}

Widget verticalSpaceTiny = const VerticalSpacers(boyut: 0.02);
Widget verticalSpaceSmall = const VerticalSpacers(boyut: 0.08);
Widget verticalSpaceRegular = const VerticalSpacers(boyut: 0.15);
Widget verticalSpaceMedium = const VerticalSpacers(boyut: 0.25);
Widget verticalSpaceLarge = const VerticalSpacers(boyut: 0.35);
