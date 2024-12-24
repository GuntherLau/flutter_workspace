
import 'package:reflectable/reflectable.dart';

class ReflectionService {

  static final ReflectionService _instance = ReflectionService._internal();
  ReflectionService._internal();
  static ReflectionService get instance => _instance;

  late Reflectable _reflectorModel;

  Future<void> init(Reflectable data) async {
    _reflectorModel = data;
    print("ReflectionService.init success");
  }

  // 通过反射获取类名的方法，传入的类型T必须继承自Object
  String getClassName<T>() {
    var classMirror = _reflectorModel.reflectType(T) as ClassMirror;
    return classMirror.simpleName;
  }

  // 通过反射获取表名的方法，传入的类型T必须继承自Object，这里简单将类名转小写作为表名，可按需调整
  String getTableName<T>() {
    return getClassName<T>().toLowerCase();
  }

  Map<String, String> getFieldsAndTypes<T>() {
    var classMirror = _reflectorModel.reflectType(T) as ClassMirror;
    return Map.fromEntries(
      classMirror.declarations.values
          .whereType<VariableMirror>()
          .where((v) => !v.isStatic) // 过滤静态字段
          .map((v) => MapEntry(v.simpleName, v.reflectedType.toString())),
    );
  }


}