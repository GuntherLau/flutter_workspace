import 'package:get/get.dart';

abstract class AppRoutes {
  List<GetPage> getPages();

  String get initialRoute => "/";
}