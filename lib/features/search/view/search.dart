import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ulearning_app/common/utils/image_res.dart';
import 'package:flutter_ulearning_app/common/widgets/app_bar.dart';
import 'package:flutter_ulearning_app/common/widgets/search_widgets.dart';
import 'package:flutter_ulearning_app/features/search/widget/courses_search_widgets.dart';

import '../controller/courses_search_controller.dart';

class Search extends ConsumerWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchProvider = ref.watch(coursesSearchControllerProvider);
    return Scaffold(
      appBar: buildGlobalAppbar(title: "Search Courses"),
      body: RefreshIndicator(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                // ✅ Ảnh bo góc, đổ bóng nhẹ
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                      image: const DecorationImage(
                        image: AssetImage(ImageRes.banner2),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                AppSearchBar(
                  searchFunc: (search) {
                    ref
                        .watch(coursesSearchControllerProvider.notifier)
                        .searchData(search!);
                  },
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: switch (searchProvider) {
                    AsyncData(:final value) =>
                      value!.isEmpty
                          ? Center(child: const CircularProgressIndicator())
                          : CoursesSearchWidgets(value: value),
                    AsyncError(:final error) => Text('Error $error'),
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
        ),
        onRefresh: () {
          return ref
              .watch(coursesSearchControllerProvider.notifier)
              .reloadSearchData();
        },
      ),
    );
  }
}
