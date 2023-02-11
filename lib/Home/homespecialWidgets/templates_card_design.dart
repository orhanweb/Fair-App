import 'package:fair_app/Core/Constants/const.dart';
import 'package:flutter/material.dart';

class DesignedCard extends StatelessWidget {
  const DesignedCard({
    super.key,
    this.backGroundColor,
    this.onTap,
    this.titleName = "No name field",
  });
  //Variables
  final Color? backGroundColor;
  final String titleName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.02, vertical: height * 0.007),
        height: height * 0.11,
        child: Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          shadowColor: kcPrimaryCascadeTwilight,
          color: backGroundColor,
          child: InkWell(
            onTap: onTap,
            child: Center(
                child: Text(
              titleName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
            )),
          ),
        ));
  }
}
