import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ulearning_app/common/widgets/app_bar.dart';
import 'package:flutter_ulearning_app/common/widgets/image_widgets.dart';
import 'package:flutter_ulearning_app/common/widgets/search_widgets.dart';
import 'package:flutter_ulearning_app/features/home/controller/home_controller.dart';
import 'package:flutter_ulearning_app/features/home/view/widgets/home_widget.dart';

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
      appBar: homeAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              HelloText(),
              UserName(),
              SizedBox(height: 20),
              searchBar(),
              SizedBox(height: 20),
              HomeBanner(ref: ref, controller: _controller),
              HomeMenuBar(),
              CourceItemGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
