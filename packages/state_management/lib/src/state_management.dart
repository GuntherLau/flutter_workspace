

import 'package:common/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/framework_splash/view.dart';
import 'routes/app_routes.dart';
import 'services/route_service.dart';

Widget getCustomApp({
  required AppRoutes routes,
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
          RouteService.instance.pushToView(routes.initialRoute);
        }
    ),
  );
}