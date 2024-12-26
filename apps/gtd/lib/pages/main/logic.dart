import 'package:state_management/main.dart';
import 'package:storage/main.dart';
import '../../model/task.dart';
import '../../model/user.dart';
import 'state.dart';
import 'widgets/main_drawer_controller.dart';

class MainLogic extends GetxController {
  final MainState state = MainState();
  final MainDrawerController mainDrawerController = MainDrawerController();

  @override
  void onInit() {
    Get.put<MainDrawerController>(mainDrawerController);
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    SqliteService.instance.createTable<Task>();
    // test();
    SqliteService.instance.getTableNames().then((value) {
      print("表名:$value");
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    Get.delete<MainDrawerController>();
  }

  Future<void> test() async {
    await SqliteService.instance.createTable<User>();
    int resultId = await SqliteService.instance.insert<User>(User( name: 'John Doe', email: 'john@example.com'));
    print("插入resultId:$resultId");
    User? queryUser = await SqliteService.instance.queryById<User>(resultId, User.fromJson);
    print("查询:$queryUser");
    List<User> userList = await SqliteService.instance.queryAll<User>(User.fromJson);
    print("${userList.length}个用户");
    for(int i=0; i<userList.length; i++) {
      print(userList[i]);
    }
  }

  onBottomNavClicked(int index) {
    state.bottomNavIndex.value = index;
  }

}


