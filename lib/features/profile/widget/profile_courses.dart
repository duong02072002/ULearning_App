import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ulearning_app/common/routes/app_routes_names.dart';
import 'package:flutter_ulearning_app/common/utils/app_colors.dart';
import 'package:flutter_ulearning_app/common/utils/image_res.dart';
import 'package:flutter_ulearning_app/common/widgets/image_widgets.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';

class ProfileCourses extends StatelessWidget {
  const ProfileCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     const ProfileLink(
      //       imagePath: ImageRes.profileVideo,
      //       text: "My Courses",
      //     ),
      //     ProfileLink(
      //       imagePath: ImageRes.profileBook,
      //       text: "Courses Bought",
      //       func:
      //           () => Navigator.of(
      //             context,
      //           ).pushNamed(AppRoutesNames.COURSES_BOUGHT),
      //     ),
      //     const ProfileLink(imagePath: ImageRes.profileStar, text: "4.9"),
      //   ],
      // ),
    );
  }
}

class ProfileLink extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback? func;
  const ProfileLink({
    super.key,
    required this.imagePath,
    required this.text,
    this.func,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7),
        width: 100,
        decoration: BoxDecoration(
          color: AppColors.primaryElement,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.primaryElement),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImage(width: 20, height: 20, imagePath: imagePath),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text11Normal(text: text, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
