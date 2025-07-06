import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ulearning_app/common/models/lesson_entities.dart';
import 'package:flutter_ulearning_app/common/utils/constants.dart';
import 'package:flutter_ulearning_app/common/utils/image_res.dart';
import 'package:flutter_ulearning_app/common/widgets/app_shadow.dart';
import 'package:flutter_ulearning_app/common/widgets/image_widgets.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';
import 'package:flutter_ulearning_app/features/lesson_detail/controller/lesson_controller.dart';

class LessonVideos extends StatelessWidget {
  final List<LessonVideoItem> lessonData;
  final WidgetRef ref;
  Function syncVideoIndex;
  LessonVideos({
    super.key,
    required this.lessonData,
    required this.ref,
    required this.syncVideoIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
              syncVideoIndex(index);
              var vidUrl = lessonData[index].url;
              ref
                  .read(lessonDataControllerProvider.notifier)
                  .playNextVid(vidUrl!);
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
                      //Text10Normal(text: lessonData[index].description!),
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
    );
  }
}
