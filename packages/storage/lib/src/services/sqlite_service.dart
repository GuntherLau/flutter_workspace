import 'package:common/main.dart';
import 'package:flutter/widgets.dart';
import 'package:reflection/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {

  static final SqliteService _instance = SqliteService._internal();
  SqliteService._internal();
  static SqliteService get instance => _instance;

  late Database database;
  

  Future<void> init({ FutureVoidCallback? onCreate }) async {
    print("SqliteService.init");
    String path = await getDatabasesPath();
    print("getDatabasesPath $path");
    database = await openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        // 这里暂不做具体表创建，留给具体业务去定义
        print("MyFramework.SqliteService.onCreate ${onCreate != null}");
        if(onCreate != null) {
          await onCreate();
        }
      },
      version: 1,
    );
  }

  Future<List<String>> getTableNames() async {
    List<Map<String, dynamic>> tables = await database.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
    return tables.map((e) => e['name'] as String).toList();
  }

  // 根据传入的泛型类型T（要求实现TableCreatable接口）创建表
  Future<void> createTable<T>() async {
    String tableName = ReflectionService.instance.getClassName<T>();
    Map<String, String> fields = ReflectionService.instance.getFieldsAndTypes<T>();

    String sql = '''
    CREATE TABLE IF NOT EXISTS $tableName (
      ${fields.entries.map((e) => '${e.key} ${_mapDartTypeToSqlType(e.value)}').join(', ')}
    )
    ''';

    print("createTable sql: $sql");

    await database.execute(sql);
  }

  String _mapDartTypeToSqlType(String dartType) {
    switch (dartType) {
      case 'int':
        return 'INTEGER';
      case 'double':
        return 'REAL';
      case 'String':
        return 'TEXT';
      case 'bool':
        return 'INTEGER'; // SQLite doesn't support BOOLEAN directly
      default:
        throw UnsupportedError('Unsupported Dart type: $dartType');
    }
  }

  // 通用插入方法，使用泛型并适配JsonSerializableModel类型
  Future<int> insert<T extends JsonSerializableModel>(T data) async {
    String tableName = ReflectionService.instance.getTableName<T>();
    Map<String, dynamic> jsonData = data.toJson();
    return await database.insert(tableName, jsonData);
  }

  // 通用查询所有数据方法，使用泛型返回列表并适配JsonSerializableModel类型
  Future<List<T>> queryAll<T extends JsonSerializableModel>(T Function(Map<String, dynamic> json) fromJson) async {
    String tableName = ReflectionService.instance.getTableName<T>();
    List<Map<String, dynamic>> result = await database.query(tableName);
    return result.map((e) => fromJson(e)).toList();
  }

  // 通用根据条件查询数据方法，使用泛型返回单个对象或null并适配JsonSerializableModel类型
  Future<T?> queryById<T extends JsonSerializableModel>(String id, T Function(Map<String, dynamic> json) fromJson) async {
    String tableName = ReflectionService.instance.getTableName<T>();
    List<Map<String, dynamic>> result = await database.query(
      tableName,
      where: 'id =?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return fromJson(result[0]);
    }
    return null;
  }

  // 通用根据条件查询数据方法，使用泛型返回列表并适配JsonSerializableModel类型，使用反射服务类获取表名
  // where参数为条件，whereArgs为条件参数
  // 示例：queryByCondition<User>('name = ?', ['张三']);
  // 查询name为张三的用户
  // 示例：queryByCondition<User>('age > ?', [18]);
  // 查询年龄大于18的用户
  Future<List<T>> queryByCondition<T extends JsonSerializableModel>(String where, List<dynamic> whereArgs, T Function(Map<String, dynamic> json) fromJson) async {
    String tableName = ReflectionService.instance.getTableName<T>();
    List<Map<String, dynamic>> result = await database.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
    return result.map((e) => fromJson(e)).toList();
  }

  // 通用根据条件删除数据方法，使用泛型并适配JsonSerializableModel类型，使用反射服务类获取表名
  // where参数为条件，whereArgs为条件参数
  // 返回删除的行数
  // 示例：deleteByCondition<User>('name = ?', ['张三']);
  // 删除name为张三的用户
  Future<int> deleteByCondition<T extends JsonSerializableModel>(String where, List<dynamic> whereArgs) async {
    String tableName = ReflectionService.instance.getTableName<T>();
    return await database.delete(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
  }

  // 通用根据条件更新数据方法，使用泛型并适配JsonSerializableModel类型，使用反射服务类获取表名
  // where参数为条件，whereArgs为条件参数，values为要更新的数据
  // 返回更新的行数
  // 示例：updateByCondition<User>('name =
  // ?', ['张三'], {'name': '李四', 'age': 20});
  // 将name为张三的用户的name更新为李四，age更新为20
  Future<int> updateByCondition<T extends JsonSerializableModel>(String where, List<dynamic> whereArgs, Map<String, dynamic> values) async {
    String tableName = ReflectionService.instance.getTableName<T>();
    return await database.update(
      tableName,
      values,
      where: where,
      whereArgs: whereArgs,
    );
  }

  // 通用更新数据方法，使用泛型并适配JsonSerializableModel类型，使用反射服务类获取表名
  Future<int> update<T extends JsonSerializableModel>(T data) async {
    String tableName = ReflectionService.instance.getTableName<T>();
    Map<String, dynamic> jsonData = data.toJson();
    return await database.update(
      tableName,
      jsonData,
      where: 'id =?',
      whereArgs: [data.toJson()['id']],
    );
  }

  // 通用删除数据方法，使用泛型并适配JsonSerializableModel类型，使用反射服务类获取表名
  Future<int> delete<T extends JsonSerializableModel>(int id) async {
    String tableName = ReflectionService.instance.getTableName<T>();
    return await database.delete(tableName, where: 'id =?', whereArgs: [id]);
  }

  // 分页查询方法，使用泛型返回分页后的列表并适配JsonSerializableModel类型，使用反射服务类获取表名
  Future<List<T>> queryByPage<T extends JsonSerializableModel>(int page, int pageSize, T Function(Map<String, dynamic> json) fromJson) async {
    String tableName = ReflectionService.instance.getTableName<T>();
    int offset = (page - 1) * pageSize;
    List<Map<String, dynamic>> result = await database.query(
      tableName,
      limit: pageSize,
      offset: offset,
    );
    return result.map((e) => fromJson(e)).toList();
  }

}