import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

typedef OnFrameworkSplashLoad = Future<void> Function();

class FrameworkSplashPage extends StatefulWidget {

  final OnFrameworkSplashLoad onLoad;
  final VoidCallback onCompleted;

  const FrameworkSplashPage({
    super.key,
    required this.onLoad,
    required this.onCompleted
  });

  @override
  State<FrameworkSplashPage> createState() => _FrameworkSplashPageState();
}

class _FrameworkSplashPageState extends State<FrameworkSplashPage> {
  final FrameworkSplashLogic logic = Get.put(FrameworkSplashLogic());
  final FrameworkSplashState state = Get.find<FrameworkSplashLogic>().state;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  @override
  void dispose() {
    Get.delete<FrameworkSplashLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: const Center(
          child: Text("Framework SplashPage", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }

  _startLoading() async {
    await widget.onLoad();
    widget.onCompleted();
  }

}