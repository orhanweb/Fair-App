import 'package:fair_app/shared/const.dart';
import 'package:flutter/material.dart';

class DesignedCard extends StatelessWidget {
  const DesignedCard(
      {super.key,
      this.imageName = "assets/images/cardimages/business-goal.png",
      this.onTap,
      this.titleName = "No name field"});
  //Variables
  final String imageName;
  final String titleName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: height * 0.01),
      height: height * 0.3,
      width: width * 0.45,
      child: Card(
          clipBehavior: Clip.hardEdge,
          shadowColor: kcPrimaryCascadeTwilight,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 20,
          child: InkWell(
            onTap: onTap,
            child: Column(children: [
              Expanded(
                  flex: 8,
                  child: Image.asset(
                    imageName,
                    fit: BoxFit.contain,
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    height: height,
                    width: width,
                    color: kc3thColor,
                    child: Center(
                        child: Text(
                      titleName,
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: kcwhite, fontWeight: FontWeight.normal),
                    )),
                  ))
            ]),
          )),
    );
  }
}
