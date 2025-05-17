import 'package:flutter/material.dart';
import 'package:flutter_ulearning_app/common/utils/app_colors.dart';
import 'package:flutter_ulearning_app/common/widgets/app_bar.dart';
import 'package:flutter_ulearning_app/common/widgets/app_shadow.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';
import 'package:flutter_ulearning_app/features/sign_in/view/sign_in.dart';
import 'package:flutter_ulearning_app/features/sign_in/view/widgets/sign_in_widgets.dart';
import 'package:flutter_ulearning_app/features/sign_up/view/sign_up.dart';

Widget appButton({
  double width = 350,
  double height = 50,
  String buttonName = "",
  bool isLogin = true,
  BuildContext? context,
  void Function()? func,
}) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: width,
      height: height,
      //isLogin true then send primary color else send white color
      decoration: appBoxShadow(
        color: isLogin ? AppColors.primaryElement : Colors.white,
        boxBorder: Border.all(color: AppColors.primaryFourthElementText),
      ),
      child: Center(
        child: Text16Normal(
          text: buttonName,
          color: isLogin ? AppColors.primaryBackground : AppColors.primaryText,
        ),
      ),
    ),
  );
}
