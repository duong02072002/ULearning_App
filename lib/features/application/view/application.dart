import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ulearning_app/common/utils/app_colors.dart';
import 'package:flutter_ulearning_app/common/widgets/app_shadow.dart';
import 'package:flutter_ulearning_app/features/application/provider/application_nav_notifier.dart';
import 'package:flutter_ulearning_app/features/application/view/widgets/widgets.dart';

class Application extends ConsumerWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int index = ref.watch(applicationNavIndexProvider);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: appScreens(index: index),
          bottomNavigationBar: Container(
            width: 375,
            height: 58,
            decoration: appBoxShadowWithRadius(),
            child: BottomNavigationBar(
              currentIndex: index,
              onTap: (value) {
                ref
                    .read(applicationNavIndexProvider.notifier)
                    .changeIndex(value);
              },
              elevation: 0,
              items: bottomTabs,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: AppColors.primaryElement,
              unselectedItemColor: AppColors.primaryFourthElementText,
            ),
          ),
        ),
      ),
    );
  }
}
