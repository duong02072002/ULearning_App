import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ulearning_app/common/models/course_entities.dart';
import 'package:flutter_ulearning_app/common/routes/app_routes_names.dart';
import 'package:flutter_ulearning_app/common/utils/app_colors.dart';
import 'package:flutter_ulearning_app/common/utils/constants.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';

class CoursesBoughtWidgets extends ConsumerWidget {
  final List<CourseItem> value;
  const CoursesBoughtWidgets({super.key, required this.value});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: value.length,
      itemBuilder: (_, index) {
        return Container(
          width: 325,
          height: 80,
          margin: EdgeInsets.only(bottom: 15),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromRGBO(255, 255, 255, 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: InkWell(
            onTap:
                () => Navigator.of(context).pushNamed(
                  AppRoutesNames.COURSE_DETAIL,
                  arguments: {"id": value.elementAt(index).id},
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: NetworkImage(
                            "${AppConstants.IMAGE_UPLOADS_PATH}${value.elementAt(index).thumbnail}",
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 6),
                          width: 180,
                          child: Text13Normal(
                            maxLines: 1,
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                            text: value.elementAt(index).name.toString(),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 6),
                          width: 180,
                          child: Text10Normal(
                            color: AppColors.primaryThirdElementText,
                            text: "${value.elementAt(index).lesson_num} Lesson",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: 55,
                  child: Text13Normal(
                    text: "\$${value.elementAt(index).price}",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
