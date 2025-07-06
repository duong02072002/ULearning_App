import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ulearning_app/common/models/course_entities.dart';
import 'package:flutter_ulearning_app/common/models/lesson_entities.dart';
import 'package:flutter_ulearning_app/common/routes/app_routes_names.dart';
import 'package:flutter_ulearning_app/common/utils/app_colors.dart';
import 'package:flutter_ulearning_app/common/utils/constants.dart';
import 'package:flutter_ulearning_app/common/utils/image_res.dart';
import 'package:flutter_ulearning_app/common/widgets/app_shadow.dart';
import 'package:flutter_ulearning_app/common/widgets/button_widgets.dart';
import 'package:flutter_ulearning_app/common/widgets/image_widgets.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';
import 'package:flutter_ulearning_app/features/lesson_detail/controller/lesson_controller.dart';

class CourseDetailThumbnail extends StatelessWidget {
  final CourseItem courseItem;

  const CourseDetailThumbnail({Key? key, required this.courseItem})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBoxDecorationImage(
      imagePath: "${AppConstants.IMAGE_UPLOADS_PATH}${courseItem.thumbnail}",
      width: 325,
      height: 200,
      fit: BoxFit.fitWidth,
    );
  }
}

class CourseDetailIconText extends StatelessWidget {
  final CourseItem courseItem;

  const CourseDetailIconText({Key? key, required this.courseItem})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: 325,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutesNames.AUTHOR_PAGE,
                arguments: {"token": courseItem.user_token},
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: appBoxShadow(radius: 7),
              child: const Text10Normal(
                text: "Author Page",
                color: AppColors.primaryElementText,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30),
            child: Row(
              children: [
                const AppImage(imagePath: ImageRes.people),
                Text11Normal(
                  text:
                      courseItem.follow == null
                          ? "0"
                          : courseItem.follow.toString(),
                  color: AppColors.primaryThirdElementText,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30),
            child: Row(
              children: [
                const AppImage(imagePath: ImageRes.star),
                Text11Normal(
                  text:
                      courseItem.score == null
                          ? "0"
                          : courseItem.score!.toStringAsFixed(1),
                  color: AppColors.primaryThirdElementText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CourseDetailDescription extends StatelessWidget {
  final CourseItem courseItem;

  const CourseDetailDescription({Key? key, required this.courseItem})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text16Normal(
            text: courseItem.name == null ? "No name found" : courseItem.name!,
            color: AppColors.primaryText,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.bold,
          ),
          Container(
            child: Text11Normal(
              text: courseItem.description ?? "No description found",
              color: AppColors.primaryThirdElementText,
            ),
          ),
        ],
      ),
    );
  }
}

class CourseDetailGoBuyButton extends StatelessWidget {
  final CourseItem courseItem;
  final bool isBought;

  const CourseDetailGoBuyButton({
    Key? key,
    required this.courseItem,
    required this.isBought,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: AppButton(
        buttonName: isBought ? "Purchased" : "Go buy",
        isLogin: !isBought, // đổi màu nếu đã mua
        func:
            isBought
                ? null
                : () {
                  Navigator.of(
                    context,
                  ).pushNamed("/buy_course", arguments: {"id": courseItem.id});
                },
      ),
    );
  }
}

class CourseDetailIncludes extends StatelessWidget {
  final CourseItem courseItem;

  const CourseDetailIncludes({Key? key, required this.courseItem})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text14Normal(
            text: "Course includes",
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 12),
          CourseInfo(
            imagePath: ImageRes.videoDetail,
            length: courseItem.video_len,
            infoText: "Hours video",
          ),
          SizedBox(height: 16),
          CourseInfo(
            imagePath: ImageRes.fileDetail,
            length: courseItem.lesson_num,
            infoText: "Number of files",
          ),
          // SizedBox(height: 16),
          // CourseInfo(
          //   imagePath: ImageRes.downloadDetail,
          //   length: courseItem.down_num,
          //   infoText: "Number of items to download",
          // ),
        ],
      ),
    );
  }
}

class CourseInfo extends StatelessWidget {
  final String imagePath;
  final int? length;
  final String? infoText;

  const CourseInfo({
    Key? key,
    required this.imagePath,
    this.length,
    this.infoText = "item",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: AppImage(imagePath: imagePath, width: 30, height: 30),
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text11Normal(
            color: AppColors.primarySecondaryElementText,
            text: length == null ? "0 $infoText" : "$length $infoText",
          ),
        ),
      ],
    );
  }
}

class LessonInfo extends StatelessWidget {
  final List<LessonItem> lessonData;
  final WidgetRef ref;

  const LessonInfo({Key? key, required this.lessonData, required this.ref})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          lessonData.isNotEmpty
              ? const Text14Normal(
                text: "Lesson list",
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
              )
              : const Text14Normal(
                text: "Lesson list is empty",
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: lessonData.length,
            itemBuilder: (_, index) {
              return Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: 325,
                height: 80,
                decoration: appBoxShadow(
                  radius: 10,
                  sR: 2,
                  bR: 3,
                  color: const Color.fromRGBO(255, 255, 255, 1),
                ),
                child: InkWell(
                  onTap: () {
                    ref.watch(
                      lessonDetailControllerProvider(
                        index: lessonData[index].id!,
                      ),
                    );
                    Navigator.of(context).pushNamed(
                      "/lesson_detail",
                      arguments: {"id": lessonData[index].id!},
                    );
                  },
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppBoxDecorationImage(
                        width: 60,
                        height: 60,
                        imagePath:
                            "${AppConstants.IMAGE_UPLOADS_PATH}${lessonData[index].thumbnail}",
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text13Normal(text: lessonData[index].name),
                            Text10Normal(text: lessonData[index].description!),
                          ],
                        ),
                      ),
                      // Expanded(child:Container()),
                      const AppImage(
                        imagePath: ImageRes.arrowRight,
                        width: 24,
                        height: 24,
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
