import 'package:fair_app/Home/homespecialWidgets/templates_cart_design.dart';
import 'package:flutter/material.dart';

class TemplatesView extends StatelessWidget {
  const TemplatesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DesignedCard(
                imageName: "assets/images/cardimages/career.png",
                onTap: () {},
              ),
              DesignedCard(
                imageName: "assets/images/cardimages/marketer.png",
                onTap: () {},
              ),
            ],
          );
        },
      ),
    );
  }
}


// Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: const [DesignedCard(), DesignedCard()],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: const [DesignedCard(), DesignedCard()],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: const [DesignedCard(), DesignedCard()],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: const [DesignedCard(), DesignedCard()],
//             ),
//           ],
//         ),