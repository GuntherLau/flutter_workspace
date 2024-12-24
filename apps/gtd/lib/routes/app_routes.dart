

import 'package:get/get.dart';
import 'package:state_management/main.dart';

import '../pages/main/binding.dart';
import '../pages/main/view.dart';

class Routes extends AppRoutes {

  static const String splash = "/framework_splash";
  static const String main = "/main";

  @override
  String get initialRoute => "/main";

  @override
  List<GetPage> getPages() {
    return [
      GetPage(name: main, page: () => MainPage(), binding: MainBinding())
    ];
  }

}