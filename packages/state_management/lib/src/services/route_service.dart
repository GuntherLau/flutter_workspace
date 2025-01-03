

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteService {

  static final RouteService _instance = RouteService._internal();
  RouteService._internal();
  static RouteService get instance => _instance;

  void to(dynamic page , { bool preventDuplicates = true, ValueChanged<dynamic>? onBack }) {
    Get.to(page, preventDuplicates: preventDuplicates)?.then((value) {
      if(onBack != null) {
        onBack(value);
      }
    });
  }

  void pushToView(String pagName, { dynamic arguments, bool offAll = false,bool offLast = false, ValueChanged<dynamic>? onBack }) {
    if(offAll == true) {
      Get.offAllNamed(pagName,arguments: arguments)?.then((value) {
        if(onBack != null) {
          onBack(value);
        }
      });
    }else if(offLast == true) {
      Get.offNamed(pagName,arguments: arguments)?.then((value) {
        if(onBack != null) {
          onBack(value);
        }
      });
    }else{
      Get.toNamed(pagName,arguments: arguments)?.then((value) {
        if(onBack != null) {
          onBack(value);
        }
      });
    }
  }

  void popView({ dynamic result }) {
    Get.back(result: result);
  }

}