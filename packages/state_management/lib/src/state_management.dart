

import 'package:common/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theming/main.dart';

import 'pages/framework_splash/view.dart';
import 'routes/app_routes.dart';
import 'services/route_service.dart';

Widget getCustomApp({
  required AppRoutes routes,
  required Translations messages,
  FutureVoidCallback? onLoad,
}) {
  return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    enableLog: true,
    getPages: routes.getPages(),
    home: FrameworkSplashPage(
        onLoad: () async {
          if(onLoad != null) {
            await onLoad();
          }
        },
        onCompleted: () {
          RouteService.instance.pushToView(routes.initialRoute, offAll: true);
        }
    ),
    //  主题
    themeMode: ThemeMode.dark,
    theme: AppThemes.lightTheme,
    darkTheme: AppThemes.darkTheme,
    //  国际化
    translations: messages,
    locale: const Locale("en", "US"),
  );
}