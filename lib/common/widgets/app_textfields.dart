import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';

import 'app_shadow.dart';
import 'image_widgets.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.text = "",
    this.iconName = "",
    this.hintText = "Type in your info",
    this.obscureText = false,
    this.func,
  });

  final TextEditingController? controller;
  final String text;
  final String iconName;

  final String hintText;
  final bool obscureText;
  final void Function(String value)? func;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text14Normal(text: text),
          SizedBox(height: 5),
          Container(
            width: 325,
            height: 50,
            //color: Colors.red,
            decoration: appBoxDecorationTextField(),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 17),
                  child: AppImage(imagePath: iconName),
                ),
                AppTextFieldOnly(
                  controller: controller,
                  hintText: hintText,
                  func: func,
                  obscureText: obscureText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppTextFieldOnly extends StatelessWidget {
  const AppTextFieldOnly({
    super.key,
    this.controller,
    this.hintText = "Type in your info here",
    this.width = 280,
    this.height = 50,
    this.func,
    this.obscureText = false,
    this.search = false,
  });

  final TextEditingController? controller;
  final String hintText;
  final bool? search;
  final double width;
  final double height;
  final void Function(String value)? func;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        onChanged: search == false ? (value) => func!(value) : null,
        onSubmitted: search == true ? (value) => func!(value) : null,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 7, left: 10),
          hintText: hintText,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          //default border without any input
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          //focused border is with input
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),

        maxLines: 1,
        autocorrect: false,
        //by defualt it's false
        obscureText: obscureText,
      ),
    );
  }
}
