import 'package:flutter/material.dart';
import 'package:state_management/main.dart';

import 'routes/app_routes.dart';

void main() {
  runApp(getCustomApp(
    routes: Routes(),
    onLoad: () async {
        await Future.delayed(const Duration(seconds: 3));
    }
  ));
}