import 'package:common/main.dart';
import 'package:flutter/material.dart';
import 'package:gtd/main.reflectable.dart';
import 'package:reflection/main.dart';
import 'package:state_management/main.dart';
import 'package:storage/main.dart';
import 'package:theming/main.dart';

import 'routes/app_routes.dart';

const reflectorModel = ReflectorModel();

void main() {
  initializeReflectable();

  runApp(CustomThemeProvider(
      child: getCustomApp(
          routes: Routes(),
          onLoad: () async {
            await ReflectionService.instance.init(reflectorModel);
            await SpService.instance.init();
            await SqliteService.instance.init();
            await Future.delayed(const Duration(seconds: 3));
          }
      )
  ));
}
