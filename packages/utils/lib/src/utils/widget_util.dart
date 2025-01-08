import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ModalPopupSize {
  Big,
  Middle,
  Small
}

class WidgetUtil {

  static Future<T> showModalPopup<T>(BuildContext context, Widget child, {
    ModalPopupSize size = ModalPopupSize.Middle,
    double? height,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius
  }) async {
    double maxHeight;
    if(height != null) {
      maxHeight = height;
    } else {
      double fullHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight;
      switch(size) {
        case ModalPopupSize.Big:
          maxHeight = fullHeight;
          break;
        case ModalPopupSize.Middle:
          maxHeight = fullHeight / 2;
          break;
        case ModalPopupSize.Small:
          maxHeight = fullHeight / 3;
          break;
      }
    }
    T result = await showCupertinoModalPopup(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) => Container(
          width: double.maxFinite,
          height: maxHeight,
          decoration: BoxDecoration(
              color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
              borderRadius: borderRadius ?? BorderRadius.vertical(top: Radius.circular(16), bottom: Radius.zero)
          ),
          child: child,
        )
    );
    return result;
  }

  static showPopup(BuildContext context, Widget child, {
    ModalPopupSize size = ModalPopupSize.Middle,
    double? height,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius
  }) {
    double maxHeight;
    if(height != null) {
      maxHeight = height;
    } else {
      double fullHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight;
      switch(size) {
        case ModalPopupSize.Big:
          maxHeight = fullHeight;
          break;
        case ModalPopupSize.Middle:
          maxHeight = fullHeight / 2;
          break;
        case ModalPopupSize.Small:
          maxHeight = fullHeight / 3;
          break;
      }
    }
    showModalBottomSheet(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) => Container(
          width: double.maxFinite,
          height: maxHeight,
          decoration: BoxDecoration(
              color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
              borderRadius: borderRadius ?? BorderRadius.vertical(top: Radius.circular(16), bottom: Radius.zero)
          ),
          child: child,
        )
    );
  }


}