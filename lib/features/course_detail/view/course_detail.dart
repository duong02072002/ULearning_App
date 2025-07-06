import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ulearning_app/common/utils/app_colors.dart';
import 'package:flutter_ulearning_app/common/widgets/app_bar.dart';
import 'package:flutter_ulearning_app/features/course_detail/controller/course_controller.dart';
import 'package:flutter_ulearning_app/features/course_detail/view/widget/course_detail_widgets.dart';
import 'package:flutter_ulearning_app/features/course_detail/reviews/view/review_section.dart';
import 'package:flutter_ulearning_app/common/utils/constants.dart';
import 'package:flutter_ulearning_app/common/widgets/image_widgets.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';
import 'package:flutter_ulearning_app/features/lesson_detail/controller/lesson_controller.dart';
import 'package:flutter_ulearning_app/common/models/lesson_entities.dart';
import 'package:flutter_ulearning_app/global.dart';

class CourseDetail extends ConsumerStatefulWidget {
  const CourseDetail({Key? key}) : super(key: key);

  @override
  ConsumerState<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends ConsumerState<CourseDetail> {
  late int courseId;
  bool _showReview = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    courseId = args['id'] as int;
  }

  @override
  Widget build(BuildContext context) {
    final courseAsync = ref.watch(
      courseDetailControllerProvider(index: courseId),
    );
    final lessonAsync = ref.watch(
      courseLessonListControllerProvider(index: courseId),
    );
    final currentUserToken = Global.storageService.getUserProfile().token ?? '';

    return Scaffold(
      appBar: buildGlobalAppbar(title: "Course detail"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              courseAsync.when(
                data: (course) {
                  if (course == null) return const SizedBox.shrink();

                  return lessonAsync.when(
                    data: (lessons) {
                      final isBought = lessons != null && lessons.isNotEmpty;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CourseDetailThumbnail(courseItem: course),
                          CourseDetailIconText(courseItem: course),
                          CourseDetailDescription(courseItem: course),
                          CourseDetailGoBuyButton(
                            courseItem: course,
                            isBought: isBought,
                          ),
                          CourseDetailIncludes(courseItem: course),
                          const SizedBox(height: 12),
                          InkWell(
                            onTap:
                                () =>
                                    setState(() => _showReview = !_showReview),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text16Normal(
                                  text: "Đánh giá khóa học",
                                  color: AppColors.primaryText,
                                  fontWeight: FontWeight.bold,
                                ),
                                Icon(
                                  _showReview
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          if (_showReview)
                            ReviewSection(
                              courseId: course.id!,
                              initialRatingCount: course.ratingCount ?? 0,
                              initialScore: course.score?.toDouble() ?? 0.0,
                              canReview: isBought,
                              currentUserToken: currentUserToken,
                            ),
                        ],
                      );
                    },
                    loading:
                        () => const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 32),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    error:
                        (e, st) => Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Text("Lỗi tải thông tin bài học: $e"),
                        ),
                  );
                },
                loading:
                    () => const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                error:
                    (e, st) => Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text("Lỗi tải thông tin khóa học: $e"),
                    ),
              ),
              lessonAsync.when(
                data:
                    (lessons) =>
                        (lessons == null || lessons.isEmpty)
                            ? const SizedBox.shrink()
                            : LessonInfo(lessonData: lessons, ref: ref),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
