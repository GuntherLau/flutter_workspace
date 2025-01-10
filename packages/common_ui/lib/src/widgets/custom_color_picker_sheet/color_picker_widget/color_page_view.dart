
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnColorPageChanged = void Function(int categoryIndex, int colorIndex);

class ColorPageView extends StatefulWidget {

  final int categoryIndex;
  final List<Map<Color, String>> colorList;
  final OnColorPageChanged onSelected;
  final int selectedCategoryIndex;
  final int selectedColorIndex;

  const ColorPageView({
    super.key,
    required this.categoryIndex,
    required this.onSelected,
    required this.selectedCategoryIndex,
    required this.selectedColorIndex,
    required this.colorList,
  });

  @override
  State<ColorPageView> createState() => _ColorPageViewState();
}

class _ColorPageViewState extends State<ColorPageView> {
  final int columns = 6;
  final int rows = 3;
  int _selectedColorIndex = 0;

  @override
  void initState() {
    _selectedColorIndex = widget.selectedColorIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: GridView.count(
    //     crossAxisCount: columns,
    //     children: List.generate(
    //       widget.colorList.length,
    //           (index) {
    //         if (index >= widget.colorList.length) return Container();
    //         var color = widget.colorList[index];
    //         final Color _color = color.keys.first;
    //         return Container(
    //           alignment: Alignment.center,
    //           child: GestureDetector(
    //             behavior: HitTestBehavior.opaque,
    //             onTap: () {
    //               print("选择前:$_color");
    //               widget.onSelected(widget.categoryIndex, index);
    //             },
    //             child: LayoutBuilder(
    //               builder: (BuildContext context, BoxConstraints constraints) {
    //                 double width = constraints.maxWidth * 0.8;
    //                 double height = constraints.maxHeight * 0.8;
    //                 return Container(
    //                   width: width,
    //                   height: height,
    //                   decoration: BoxDecoration(
    //                     color: _color,
    //                     shape: BoxShape.circle,
    //                   ),
    //                   child: widget.categoryIndex == widget.selectedColorIndex && index == widget.selectedColorIndex ? const Icon(Icons.check, color: Colors.white) : null,
    //                 );
    //               },
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    // );
    return _buildContent(context);
  }

  _buildContent(BuildContext context) {
    return Container(
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, index) {
            return _buildTile(context, index);
          },
          itemCount: widget.colorList.length,
      ),
    );
  }

  _buildTile(BuildContext context, int index) {
    var color = widget.colorList[index];
    final Color _color = color.keys.first;
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // print("ColorPageView.onclick categoryIndex:${widget.categoryIndex} _selectedColorIndex:$_selectedColorIndex");
          widget.onSelected(widget.categoryIndex, index);
          setState(() {
            _selectedColorIndex = index;
          });
        },
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double width = constraints.maxWidth * 0.8;
            double height = constraints.maxHeight * 0.8;
            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: _color,
                shape: BoxShape.circle,
                border: Border.all(
                    width: 1,
                    color: index == _selectedColorIndex
                        ? Colors.white
                        : _color
                ),
              ),
              child: index == _selectedColorIndex ? Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                  shadows: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 2,
                    )
                  ],
              ) : null,
            );
          },
        ),
      ),
    );
  }

}