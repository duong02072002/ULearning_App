import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ulearning_app/common/utils/image_res.dart';
import 'package:flutter_ulearning_app/common/widgets/app_bar.dart';
import 'package:flutter_ulearning_app/common/widgets/search_widgets.dart';
import 'package:flutter_ulearning_app/features/courses_bought/controller/courses_bought_controller.dart';
import 'package:flutter_ulearning_app/features/courses_bought/widget/courses_bought_widgets.dart';

class CoursesBought extends ConsumerWidget {
  const CoursesBought({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesList = ref.watch(coursesBoughtControllerProvider);

    return Scaffold(
      appBar: buildGlobalAppbar(title: "Your Courses"),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(coursesBoughtControllerProvider.notifier)
              .reloadCourses();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // ✅ Ảnh bo góc, đổ bóng nhẹ
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage(ImageRes.banner1),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: AppSearchBar(
                searchFunc: (search) {
                  ref
                      .read(coursesBoughtControllerProvider.notifier)
                      .searchCourses(search ?? "");
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: switch (coursesList) {
                AsyncData(:final value) =>
                  value == null || value.isEmpty
                      ? const Center(
                        child: Text(
                          "No courses found.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueAccent,
                          ),
                        ),
                      )
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: CoursesBoughtWidgets(value: value),
                      ),
                AsyncError(:final error) => Center(
                  child: Text('Error: $error'),
                ),
                _ => const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.red,
                      strokeWidth: 2,
                    ),
                  ),
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
