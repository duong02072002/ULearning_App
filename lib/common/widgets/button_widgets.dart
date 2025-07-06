import 'package:flutter/material.dart';
import 'package:flutter_ulearning_app/common/utils/app_colors.dart';
import 'package:flutter_ulearning_app/common/widgets/app_bar.dart';
import 'package:flutter_ulearning_app/common/widgets/app_shadow.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';
import 'package:flutter_ulearning_app/features/sign_in/view/sign_in.dart';
import 'package:flutter_ulearning_app/features/sign_in/view/widgets/sign_in_widgets.dart';
import 'package:flutter_ulearning_app/features/sign_up/view/sign_up.dart';

class AppButton extends StatelessWidget {
  final double width;
  final double height;
  final String buttonName;
  final bool isLogin;
  final BuildContext? context;
  final void Function()? func;
  final bool isDisable; // ✅

  const AppButton({
    super.key,
    this.width = 325,
    this.height = 50,
    this.buttonName = "",
    this.isLogin = true,
    this.context,
    this.func,
    this.isDisable = false, // ✅
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisable ? null : func, // ✅ không bấm được nếu disable
      child: Container(
        width: width,
        height: height,
        decoration: appBoxShadow(
          color:
              isDisable
                  ? Colors
                      .grey // ✅ màu nền xám khi bị disable
                  : isLogin
                  ? AppColors.primaryElement
                  : Colors.white12,
          boxBorder: Border.all(color: AppColors.primaryFourthElementText),
        ),
        child: Center(
          child: Text16Normal(
            text: buttonName,
            color:
                isDisable
                    ? Colors
                        .white70 // ✅ chữ mờ hơn
                    : isLogin
                    ? AppColors.primaryBackground
                    : AppColors.primaryText,
          ),
        ),
      ),
    );
  }
}
