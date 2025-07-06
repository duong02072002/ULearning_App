import 'package:flutter/material.dart';
import 'package:flutter_ulearning_app/common/utils/app_colors.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';

AppBar buildAppbar({String title = ""}) {
  return AppBar(
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1),
      child: Container(
        color: Colors.grey.withOpacity(0.3),
        height: 1,
        //child: Text("hello", style: TextStyle(fontSize: 50)),
      ),
    ),
    title: Text16Normal(text: title, color: AppColors.primaryText),
  );
}

AppBar buildGlobalAppbar({String title = ""}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold, // Chữ in đậm
        color: AppColors.primaryText,
      ),
    ),
  );
}
