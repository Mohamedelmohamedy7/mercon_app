 import 'package:core_project/View/Screen/DashBoard/DashBoardSCreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/dashboard_super_admin.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/theme_provider.dart';
import '../View/Screen/PartAuth/LoginScreen.dart';
import '../View/Screen/PartAuth/SplashScreen.dart';
import '../View/Screen/PartAuth/onBoardingScreen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String welcomeRoute = "/Welcome";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String selectTypeRoute = "/selectType";
  static const String dashBoard = "/dashBoard";
  static const String dashBoardAdmin = "/dashBoardAdmin";
  static const String registerRoute = "/register";
  static const String verifyRoute = "/verify";
  static const String homeRoute = "/home";
  static const String internalWelcomeRoute = "/internalWelcome";
  static const String tabBarRoute = "/tabBar";

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
        case Routes.splashRoute:
          return MaterialPageRoute(builder: (_) => const SplashScreen());
        case Routes.dashBoard:
          return MaterialPageRoute(builder: (_) => const DashBoardScreen());
      case Routes.dashBoardAdmin:
        return MaterialPageRoute(builder: (_) => const DashBoardSuperAdmin());

      //   case Routes.updateSettingRoute:
      //     return MaterialPageRoute(builder: (_) => const UpdateScreen());
      //   case Routes.noInternetScreenRoute:
      //     return MaterialPageRoute(builder: (_) => const NoInternetScreen());
      //   case Routes.cartRoute:
      //     return MaterialPageRoute(builder: (_) => const CartScreen());
        case Routes.loginRoute:
          return MaterialPageRoute(builder: (_) =>   const LoginScreen());
        case Routes.onBoardingRoute:
          return MaterialPageRoute(builder: (_) => onBoardingScreen());
      default:
        return unDefinedRoute(routeSettings.name);
    }
  }

  static Route<dynamic> unDefinedRoute(String? name) {

    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("No Route Found"),
              ),
              body: Builder(builder: (context) {
                return GestureDetector(
                    onTap: () {
                      print(Provider.of<ThemeProvider>(context, listen: false)
                          .darkTheme);
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                      print(Provider.of<ThemeProvider>(context, listen: false)
                          .darkTheme);
                    },
                    child: Center(
                        child: Text(
                      "Carats".tr(),
                    )));
              }),
            ));
  }
}
