import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
 import 'Provider/theme_provider.dart';
import 'helper/Route_Manager.dart';
import 'helper/theme/dark_theme.dart';
import 'helper/theme/light_theme.dart';
import 'main.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
       SystemUiOverlayStyle(
        statusBarColor: Color(0xFF695c4c),
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return SafeArea(
      top: false,
      bottom: true,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
        initialRoute: Routes.splashRoute,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}

