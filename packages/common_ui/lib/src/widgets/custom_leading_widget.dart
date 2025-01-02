

import 'package:flutter/cupertino.dart';

import 'custom_icon_button.dart';

class CustomLeadingWidget extends StatelessWidget {

  final VoidCallback? onPress;

  const CustomLeadingWidget({
    super.key,
    this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: CupertinoIcons.arrow_left,
      press: () {
        if(onPress != null) {
          onPress!();
        } else {
          Navigator.of(context).pop();
        }
      },
    );
  }

}