

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../custom_icon_button.dart';
import 'color_type_list.dart';
import 'color_types.dart';
import 'shading_list.dart';

Future<Color?> showCustomMaterialColorPickerSheet(BuildContext context) async {
  double maxHeight = MediaQuery.of(context).size.height;
  double height = MediaQuery.of(context).size.height / 2 - MediaQuery.of(context).padding.bottom;
  Color? result = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      // backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
          initialChildSize: height / maxHeight,
          minChildSize: height * 0.3 / maxHeight,
          maxChildSize: height / maxHeight,
          expand: false,
          builder: (_, controller) => CustomMaterialColorPickerSheet()
      )
  );
  return result;
}

class CustomMaterialColorPickerSheet extends StatefulWidget {

  @override
  State<CustomMaterialColorPickerSheet> createState() => _CustomMaterialColorPickerSheetState();
}

class _CustomMaterialColorPickerSheetState extends State<CustomMaterialColorPickerSheet> {

  final ShadingListController _shadingListController = ShadingListController();
  Color? _currentShading;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CustomIconButton(
                  icon: CupertinoIcons.xmark,
                  press: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ColorTypeList(
                    onPrimaryChanged: (List<Color> primaryColor) {
                      setState(() => _currentShading = null);
                      _shadingListController.onPrimaryColorChanged(primaryColor);
                    },
                  ),
                ),
                SizedBox(width: 20),
                CustomIconButton(
                  // svgSrc: okIcon,
                  icon: CupertinoIcons.checkmark_alt,
                  press: () {
                    Navigator.of(context).pop(_currentShading);
                  },
                ),
              ],
            ),
          ),
          Expanded(child: ShadingList(
            shadingListController: _shadingListController,
            onColorChanged: (Color value) {
              setState(() => _currentShading = value);
            },

          )),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}