import 'package:get/get.dart';
import 'package:storage/main.dart';
import '../../model/user.dart';
import 'state.dart';

class MainLogic extends GetxController {
  final MainState state = MainState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    test();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
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


