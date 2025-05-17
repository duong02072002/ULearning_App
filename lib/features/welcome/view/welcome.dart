import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ulearning_app/common/utils/image_res.dart';
import 'package:flutter_ulearning_app/common/widgets/text_widgets.dart';
import 'package:flutter_ulearning_app/features/welcome/provider/welcome_notifier.dart';
import 'package:flutter_ulearning_app/features/welcome/view/widgets/widgets.dart';

//final indexProvider = StateProvider<int>((ref) => 0);

class Welcome extends ConsumerWidget {
  Welcome({super.key});

  final PageController _controller = PageController();
  // int dotsIndex = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //print("my dots value is $dotsIndex");
    final index = ref.watch(indexDotProvider);
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            margin: EdgeInsets.only(top: 30),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                //showing our three welcome pages
                PageView(
                  onPageChanged: (value) {
                    print("------mu index value is $value");
                    //dotsIndex = value;
                    ref.read(indexDotProvider.notifier).changeIndex(value);
                  },
                  controller: _controller,
                  //scrollDirection: AxisDirection.up,
                  scrollDirection: Axis.horizontal,
                  children: [
                    //first page
                    AppOnboardingPage(
                      controller: _controller,
                      context: context,
                      imagePath: ImageRes.reading,
                      title: "First see learning",
                      subTitle:
                          "Forget about the paper, now learning all in one place",
                      index: 1,
                    ),
                    //second page
                    AppOnboardingPage(
                      controller: _controller,
                      context: context,
                      imagePath: ImageRes.man,
                      title: "Connect With Everyone",
                      subTitle:
                          "Alway Keep in touch with your tutor and friend. Let's get connected",
                      index: 2,
                    ),
                    //three page
                    AppOnboardingPage(
                      controller: _controller,
                      context: context,
                      imagePath: ImageRes.boy,
                      title: "Always Fascingated Learning",
                      subTitle:
                          "Anywhere, anytime. The time is at your discretion. So study wherever you can",
                      index: 3,
                    ),
                  ],
                ),
                //for showing dots
                Positioned(
                  // left: 20,
                  bottom: 50,
                  child: DotsIndicator(
                    position: index.toDouble(),
                    dotsCount: 3,
                    mainAxisAlignment: MainAxisAlignment.center,
                    decorator: DotsDecorator(
                      size: Size.square(9.0),
                      activeSize: Size(24.0, 8.0),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
