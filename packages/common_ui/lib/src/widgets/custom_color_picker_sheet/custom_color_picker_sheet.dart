import 'package:common_ui/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'service.dart';
import 'widgets/color_picker_widget.dart';


class CustomColorPickerSheet extends StatefulWidget {

  final ScrollController scrollController;
  final Color? initialColor;

  const CustomColorPickerSheet({
    super.key,
    required this.scrollController,
    this.initialColor
  });

  @override
  State<CustomColorPickerSheet> createState() => _CustomColorPickerSheetState();

  static Future<Color?> show({
    required BuildContext context,
    Color? initialColor,
  }) async {
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
            builder: (_, controller) => CustomColorPickerSheet(
              scrollController: controller,
              initialColor: initialColor,
            )
        )
    );
    return result;
  }

  static ColorPickerService get service => ColorPickerService.instance;

}

class _CustomColorPickerSheetState extends State<CustomColorPickerSheet> {

  late Color _selectedColor;

  @override
  void initState() {
    _selectedColor = widget.initialColor ?? ColorPickerService.instance.getColorByIndex(0, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CustomIconButton(
                  icon: CupertinoIcons.xmark,
                  press: () {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _selectedColor
                      ),
                    ),
                  ),
                ),
                CustomIconButton(
                  // svgSrc: okIcon,
                  icon: CupertinoIcons.checkmark_alt,
                  press: () {
                    Navigator.of(context).pop(_selectedColor);
                  },
                ),
              ],
            ),
          )),
          ColorPickerWidget(onChanged: (Color value) {
            setState(() {
              _selectedColor = value;
            });
          }),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}