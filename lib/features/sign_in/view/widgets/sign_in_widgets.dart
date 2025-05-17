import 'package:flutter/material.dart';
import 'package:flutter_ulearning_app/common/utils/app_colors.dart';
import 'package:flutter_ulearning_app/common/widgets/app_shadow.dart';
import 'package:flutter_ulearning_app/common/widgets/image_widgets.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';

Widget thirdPartyLogin() {
  return Container(
    margin: EdgeInsets.only(left: 80, right: 80, bottom: 20, top: 40),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _loginButton("assets/icons/google.png"),
        _loginButton("assets/icons/apple.png"),
        _loginButton("assets/icons/facebook.png"),
      ],
    ),
  );
}

Widget _loginButton(String imagePath) {
  return GestureDetector(
    onTap: () {},
    child: SizedBox(width: 40, height: 40, child: Image.asset(imagePath)),
  );
}
