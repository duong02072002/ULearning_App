import 'package:flutter/material.dart';
import 'package:flutter_ulearning_app/common/widgets/app_shadow.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';
import 'package:flutter_ulearning_app/page/sign_in/sign_in.dart';

Widget appOnboardingPage(
  PageController controller,
  BuildContext context, {
  String imagePath = "",
  String title = "",
  String subTitle = "",
  index = 0,
}) {
  return Column(
    children: [
      Image.asset(imagePath, fit: BoxFit.fitWidth),
      Container(
        margin: EdgeInsets.only(top: 15),
        child: text24Normal(text: title),
      ),
      Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.only(left: 30, right: 30),
        child: text16Normal(text: subTitle),
      ),
      _nextButton(index, controller, context),
    ],
  );
}

Widget _nextButton(int index, PageController controller, BuildContext context) {
  return GestureDetector(
    onTap: () {
      // print("my index is $index");
      if (index < 3) {
        controller.animateToPage(
          index,
          duration: Duration(microseconds: 300),
          curve: Curves.linear,
        );
      } else {
        Navigator.pushNamed(context, "/signIn");

        // Navigator.push<void>(
        //   context,
        //   MaterialPageRoute<void>(
        //     builder: (BuildContext context) => const SignIn(),
        //   ),
        // );
      }
    },
    child: Container(
      width: 325,
      height: 50,

      margin: EdgeInsets.only(top: 100, left: 25, right: 25),
      decoration: appBoxShadow(),
      child: Center(
        child: text16Normal(
          text: index < 3 ? "Next" : "Get started",
          color: Colors.white,
        ),
      ),
    ),
  );
}
