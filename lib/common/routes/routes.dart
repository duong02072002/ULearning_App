import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ulearning_app/common/routes/app_routes_names.dart';
import 'package:flutter_ulearning_app/features/author_page/view/author_page.dart';
import 'package:flutter_ulearning_app/features/buy_course/view/buy_course.dart';
import 'package:flutter_ulearning_app/features/chat/view/chat_page.dart';
import 'package:flutter_ulearning_app/features/course_detail/view/course_detail.dart';
import 'package:flutter_ulearning_app/features/home/view/home.dart';
import 'package:flutter_ulearning_app/features/lesson_detail/view/lesson_detail.dart';
import 'package:flutter_ulearning_app/features/courses_bought/view/courses_bought.dart';
import 'package:flutter_ulearning_app/features/profile/settings/widget/settings.dart';
import 'package:flutter_ulearning_app/global.dart';
import 'package:flutter_ulearning_app/features/application/view/application.dart';
import 'package:flutter_ulearning_app/features/sign_in/view/sign_in.dart';
import 'package:flutter_ulearning_app/features/sign_up/view/sign_up.dart';
import 'package:flutter_ulearning_app/features/welcome/view/welcome.dart';

class AppPages {
  static List<RouteEntity> routes() {
    return [
      RouteEntity(path: AppRoutesNames.WELCOME, page: Welcome()),
      RouteEntity(path: AppRoutesNames.SIGN_IN, page: SignIn()),
      RouteEntity(path: AppRoutesNames.REGISTER, page: SignUp()),
      RouteEntity(path: AppRoutesNames.APPLICATION, page: Application()),
      RouteEntity(path: AppRoutesNames.HOME, page: Home()),
      RouteEntity(
        path: AppRoutesNames.COURSE_DETAIL,
        page: const CourseDetail(),
      ),
      RouteEntity(
        path: AppRoutesNames.LESSON_DETAIL,
        page: const LessonDetail(),
      ),
      RouteEntity(path: AppRoutesNames.BUY_COURSE, page: const BuyCourse()),
      RouteEntity(path: AppRoutesNames.SETTINGS, page: const Settings()),
      RouteEntity(
        path: AppRoutesNames.COURSES_BOUGHT,
        page: const CoursesBought(),
      ),
      RouteEntity(path: AppRoutesNames.AUTHOR_PAGE, page: const AuthorPage()),
      RouteEntity(path: AppRoutesNames.CHAT_AI_PAGE, page: const ChatAIPage()),
    ];
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (kDebugMode) {
      // print("clicked route is ${settings.name}");
    }
    if (settings.name != null) {
      var result = routes().where((element) => element.path == settings.name);
      if (result.isNotEmpty) {
        // if we used this is first time or not
        bool devideFistTime = Global.storageService.getDeviceFirstOpen();

        if (result.first.path == AppRoutesNames.WELCOME && devideFistTime) {
          bool isLoggedIn = Global.storageService.isLoggedIn();
          if (isLoggedIn) {
            return MaterialPageRoute(
              builder: (_) => Application(),
              settings: settings,
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => SignIn(),
              settings: settings,
            );
          }
        } else {
          if (kDebugMode) {
            // print("App ran first time");
          }
          return MaterialPageRoute(
            builder: (_) => result.first.page,
            settings: settings,
          );
        }
      }
    }
    // if (settings.name == "/signIn") {
    //   return MaterialPageRoute(builder: (_) => SignIn(), settings: settings);
    // } else
    return MaterialPageRoute(builder: (_) => Welcome(), settings: settings);
  }
}

class RouteEntity {
  String path;
  Widget page;
  RouteEntity({required this.path, required this.page});
}
