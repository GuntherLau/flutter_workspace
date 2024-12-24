import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainLogic logic = Get.put(MainLogic());
  final MainState state = Get.find<MainLogic>().state;

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<MainLogic>();
    super.dispose();
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Text("GTD MainPage", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          child: Icon(Icons.add),
      ),
    );
  }

}
