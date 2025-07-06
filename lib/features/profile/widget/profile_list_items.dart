import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ulearning_app/common/routes/app_routes_names.dart';
import 'package:flutter_ulearning_app/common/utils/app_colors.dart';
import 'package:flutter_ulearning_app/common/utils/image_res.dart';
import 'package:flutter_ulearning_app/common/widgets/image_widgets.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';

class ProfileListItems extends StatelessWidget {
  const ProfileListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListItem(
            imagePath: ImageRes.settings,
            text: "Settings",
            func:
                () => Navigator.of(context).pushNamed(AppRoutesNames.SETTINGS),
          ),
          ListItem(imagePath: ImageRes.creditCard, text: "Payment detail"),
          ListItem(imagePath: ImageRes.award, text: "Achievement"),
          ListItem(imagePath: ImageRes.love, text: "Love"),
          ListItem(imagePath: ImageRes.reminder, text: "Reminder"),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback? func;
  const ListItem({
    super.key,
    required this.imagePath,
    required this.text,
    this.func,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            padding: EdgeInsets.all(7),
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primaryElement),
            ),
            child: AppImage(imagePath: imagePath),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, bottom: 15),
            child: Text13Normal(textAlign: TextAlign.center, text: text),
          ),
        ],
      ),
    );
  }
}
