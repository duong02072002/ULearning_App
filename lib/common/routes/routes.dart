import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ulearning_app/common/routes/app_routes_names.dart';
import 'package:flutter_ulearning_app/features/home/view/home.dart';
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
