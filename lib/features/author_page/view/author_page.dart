import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ulearning_app/common/widgets/app_bar.dart';
import 'package:flutter_ulearning_app/common/widgets/button_widgets.dart';
import 'package:flutter_ulearning_app/features/author_page/controller/author_controller.dart';
import 'package:flutter_ulearning_app/features/author_page/view/widget/author_widgets.dart';

class AuthorPage extends ConsumerStatefulWidget {
  const AuthorPage({super.key});

  @override
  ConsumerState<AuthorPage> createState() => _AuthorPageState();
}

class _AuthorPageState extends ConsumerState<AuthorPage> {
  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    //author data
    ref.watch(courseAuthorControllerProvider.notifier).init(args["token"]);
    //courses of the author
    ref.watch(authorCourseListControllerProvider.notifier).init(args["token"]);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var authorInfo = ref.watch(courseAuthorControllerProvider);
    var authorCourses = ref.watch(authorCourseListControllerProvider);
    return Scaffold(
      appBar: buildGlobalAppbar(title: "Author Page"),
      body: switch (authorInfo) {
        AsyncData(:final value) =>
          value == null
              ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black26,
                  strokeWidth: 2,
                ),
              )
              : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  child: Column(
                    children: [
                      AuthorMenu(authorInfo: value),
                      AuthorDescription(authorInfo: value),
                      //SizedBox(height: 10),
                      //go chat button
                      // AppButton(
                      //   buttonName: "Go Chat",
                      //   func: () {
                      //     print("I am tapped");
                      //   },
                      // ),
                      //SizedBox(height: 10),
                      AuthorCourses(authorCourses: authorCourses.value!),
                    ],
                  ),
                ),
              ),
        AsyncError(:final error) => Text('Error $error'),
        _ => const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(color: Colors.red, strokeWidth: 2),
          ),
        ),
      },
    );
  }
}
