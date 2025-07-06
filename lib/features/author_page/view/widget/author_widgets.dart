import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ulearning_app/common/models/course_entities.dart';
import 'package:flutter_ulearning_app/common/utils/app_colors.dart';
import 'package:flutter_ulearning_app/common/utils/constants.dart';
import 'package:flutter_ulearning_app/common/utils/image_res.dart';
import 'package:flutter_ulearning_app/common/widgets/app_shadow.dart';
import 'package:flutter_ulearning_app/common/widgets/image_widgets.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';
import 'package:flutter_ulearning_app/features/lesson_detail/controller/lesson_controller.dart';

class AuthorMenu extends StatelessWidget {
  const AuthorMenu({super.key, required this.authorInfo});
  final AuthorItem authorInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black12)],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: Image.asset(
              ImageRes.background,
              width: 325,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        "${AppConstants.IMAGE_UPLOADS_PATH}${authorInfo.avatar}",
                      ),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text13Normal(text: authorInfo.name),
                    const SizedBox(height: 4),
                    Text9Normal(
                      text: authorInfo.job ?? "A freelancer",
                      color: AppColors.primaryThirdElementText,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AuthorTextAndIcon extends StatelessWidget {
  const AuthorTextAndIcon({
    super.key,
    required this.text,
    required this.icon,
    required this.first,
  });

  final String text;
  final String icon;
  final bool first;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: first == true ? 3 : 20),
      child: Row(
        children: [
          AppImage(imagePath: icon),
          Text11Normal(text: text, color: AppColors.primaryThirdElementText),
        ],
      ),
    );
  }
}

class AuthorDescription extends StatelessWidget {
  const AuthorDescription({super.key, required this.authorInfo});
  final AuthorItem authorInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text16Normal(
            text: "About me",
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
          const SizedBox(height: 4),
          Text11Normal(
            text:
                authorInfo.description ??
                "I am a course creator. I love Flutter and React Native",
            color: AppColors.primaryThirdElementText,
          ),
        ],
      ),
    );
  }
}

class AuthorCourses extends StatelessWidget {
  final List<CourseItem> authorCourses;

  const AuthorCourses({Key? key, required this.authorCourses})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text14Normal(
            text:
                authorCourses.isNotEmpty
                    ? "Lesson list"
                    : "Lesson list is empty",
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 6),
          ListView.builder(
            itemCount: authorCourses.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              final course = authorCourses[index];
              return InkWell(
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed("/course_detail", arguments: {"id": course.id!});
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(blurRadius: 6, color: Colors.black12),
                    ],
                  ),
                  child: Row(
                    children: [
                      AppBoxDecorationImage(
                        width: 64,
                        height: 64,
                        imagePath:
                            "${AppConstants.IMAGE_UPLOADS_PATH}${course.thumbnail}",
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text13Normal(text: course.name),
                            const SizedBox(height: 4),
                            Text10Normal(
                              text: "There are ${course.lesson_num} Lessons",
                              color: AppColors.primarySecondaryElementText,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
