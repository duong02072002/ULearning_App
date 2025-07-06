import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ulearning_app/common/widgets/search_widgets.dart';
import 'package:flutter_ulearning_app/features/home/view/widgets/home_widget.dart';

import '../controller/home_controller.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late PageController _controller;

  @override
  void didChangeDependencies() {
    _controller = PageController(
      initialPage: ref.watch(homeScreenBannerDotsProvider),
    );

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: homeAppBar(ref),
      body: RefreshIndicator(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                const HelloText(),
                const UserName(),
                SizedBox(height: 20),
                //searchBar(),
                SizedBox(height: 20),
                HomeBanner(ref: ref, controller: _controller),
                const HomeMenuBar(),
                CourseItemGrid(ref: ref),
              ],
            ),
          ),
        ),
        onRefresh: () {
          return ref.refresh(homeCourseListProvider.notifier).fetchCourseList();
        },
      ),
    );
  }
}
