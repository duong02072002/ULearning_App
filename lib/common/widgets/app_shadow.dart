import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ulearning_app/common/models/course_entities.dart';
import 'package:flutter_ulearning_app/common/utils/app_colors.dart';
import 'package:flutter_ulearning_app/common/utils/constants.dart';
import 'package:flutter_ulearning_app/common/utils/image_res.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';

BoxDecoration appBoxShadow({
  Color color = AppColors.primaryElement,
  double radius = 15,
  double sR = 1,
  double bR = 2,
  BoxBorder? boxBorder,
  BorderRadius? borderRadius,
}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
    border: boxBorder,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.6),
        spreadRadius: sR,
        blurRadius: bR,
        offset: Offset(0, 1),
      ),
    ],
  );
}

BoxDecoration appBoxShadowWithRadius({
  Color color = AppColors.primaryElement,
  double radius = 15,
  double sR = 1,
  double bR = 2,
  BoxBorder? border,
}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
    border: border,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.1),
        spreadRadius: sR,
        blurRadius: bR,
        offset: const Offset(0, 1),
      ),
    ],
  );
}

BoxDecoration appBoxDecorationTextField({
  Color color = AppColors.primaryBackground,
  double radius = 15,
  Color borderColor = AppColors.primaryFourthElementText,
}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: borderColor),
  );
}

class AppBoxDecorationImage extends StatelessWidget {
  final double width;
  final double height;
  final String imagePath;
  final BoxFit fit;
  final CourseItem? courseItem;
  final VoidCallback? func;

  const AppBoxDecorationImage({
    super.key,
    this.width = 40,
    this.height = 40,
    this.imagePath = ImageRes.profile,
    this.fit = BoxFit.cover,
    this.courseItem,
    this.func,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: CachedNetworkImage(
        imageUrl: imagePath,
        imageBuilder: (context, imageProvider) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(fit: fit, image: imageProvider),
              borderRadius: BorderRadius.circular(20),
            ),
            child:
                courseItem != null
                    ? Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.only(
                        left: 20,
                        bottom: 20,
                        top: 40,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (courseItem!.name != null)
                            FadeText(
                              text: courseItem!.name!,
                              color: Colors.white,
                            ),
                          if (courseItem!.lesson_num != null)
                            FadeText(
                              text: "${courseItem!.lesson_num} Lessons",
                              color: AppColors.primaryFourthElementText,
                              fontSize: 8,
                            ),
                        ],
                      ),
                    )
                    : null,
          );
        },
        placeholder:
            (context, url) => Container(
              width: width,
              height: height,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
        errorWidget:
            (context, url, error) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageRes.defaultImg),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
      ),
    );
  }
}

// class AppBoxDecorationImage extends StatelessWidget {
//   final double width;
//   final double height;
//   final String imagePath;
//   final BoxFit fit;
//   final CourseItem? courseItem;
//   final Function()? func;

//   const AppBoxDecorationImage({
//     super.key,
//     this.width = 40,
//     this.height = 40,
//     this.imagePath = ImageRes.profile,
//     this.fit = BoxFit.fitHeight,
//     this.courseItem,
//     this.func,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: func,
//       child: CachedNetworkImage(
//         imageUrl: imagePath,
//         imageBuilder:
//             (context, imageProvider) => Container(
//               width: width,
//               height: height,
//               decoration: BoxDecoration(
//                 image: DecorationImage(fit: fit, image: imageProvider),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child:
//                   courseItem == null
//                       ? Container()
//                       : Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(left: 20),
//                             child: FadeText(text: courseItem!.name!),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(left: 20, bottom: 30),
//                             child: FadeText(
//                               text: "${courseItem!.lesson_num!} Lessons",
//                               color: AppColors.primaryFourthElementText,
//                               fontSize: 8,
//                             ),
//                           ),
//                         ],
//                       ),
//             ),
//         placeholder:
//             (context, url) => Container(
//               alignment: Alignment.center,
//               child:
//                   CircularProgressIndicator(), // you can add pre loader iamge as well to show loading.
//             ),
//         errorWidget: (context, url, error) => Image.asset(ImageRes.defaultImg),
//       ),
//     );
//   }
// }

BoxDecoration networkImageDecoration({required String imagePath}) {
  return BoxDecoration(image: DecorationImage(image: NetworkImage(imagePath)));
}
