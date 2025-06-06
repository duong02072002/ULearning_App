import 'package:flutter/material.dart';
import 'package:flutter_ulearning_app/common/utils/app_colors.dart';
import 'package:flutter_ulearning_app/common/utils/image_res.dart';

Widget appImage({
  String imagePath = ImageRes.defaultImg,
  double width = 16,
  double height = 16,
}) {
  return Image.asset(
    imagePath.isEmpty ? ImageRes.defaultImg : imagePath,
    width: width,
    height: height,
  );
}

Widget appImageWithColor({
  String imagePath = ImageRes.defaultImg,
  double width = 16,
  double height = 16,
  Color color = AppColors.primaryElement,
}) {
  return Image.asset(
    imagePath.isEmpty ? ImageRes.defaultImg : imagePath,
    width: width,
    height: height,
    color: color,
  );
}
