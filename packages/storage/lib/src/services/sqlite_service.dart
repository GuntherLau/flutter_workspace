import 'package:common/main.dart';
import 'package:reflection/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {

  static final SqliteService _instance = SqliteService._internal();
  SqliteService._internal();
  static SqliteService get instance => _instance;

  late Database _database;

  Future<void> init({ FutureVoidCallback? onCreate }) async {
    print("SqliteService.init");
    String path = await getDatabasesPath();
    print("getDatabasesPath $path");
    _database = await openDatabase(
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
    List<Map<String, dynamic>> tables = await _database.rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
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

    await _database.execute(sql);
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
    return await _database.insert(tableName, jsonData);
  }

  // 通用查询所有数据方法，使用泛型返回列表并适配JsonSerializableModel类型
  Future<List<T>> queryAll<T extends JsonSerializableModel>(T Function(Map<String, dynamic> json) fromJson) async {
    String tableName = ReflectionService.instance.getTableName<T>();
    List<Map<String, dynamic>> result = await _database.query(tableName);
    return result.map((e) => fromJson(e)).toList();
  }

  // 通用根据条件查询数据方法，使用泛型返回单个对象或null并适配JsonSerializableModel类型
  Future<T?> queryById<T extends JsonSerializableModel>(int id, T Function(Map<String, dynamic> json) fromJson) async {
    String tableName = ReflectionService.instance.getTableName<T>();
    List<Map<String, dynamic>> result = await _database.query(
      tableName,
      where: 'id =?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return fromJson(result[0]);
    }
    return null;
  }

  // 通用更新数据方法，使用泛型并适配JsonSerializableModel类型，使用反射服务类获取表名
  Future<int> update<T extends JsonSerializableModel>(T data) async {
    String tableName = ReflectionService.instance.getTableName<T>();
    Map<String, dynamic> jsonData = data.toJson();
    return await _database.update(
      tableName,
      jsonData,
      where: 'id =?',
      whereArgs: [data.toJson()['id']],
    );
  }

  // 通用删除数据方法，使用泛型并适配JsonSerializableModel类型，使用反射服务类获取表名
  Future<int> delete<T extends JsonSerializableModel>(int id) async {
    String tableName = ReflectionService.instance.getTableName<T>();
    return await _database.delete(tableName, where: 'id =?', whereArgs: [id]);
  }

  // 分页查询方法，使用泛型返回分页后的列表并适配JsonSerializableModel类型，使用反射服务类获取表名
  Future<List<T>> queryByPage<T extends JsonSerializableModel>(int page, int pageSize, T Function(Map<String, dynamic> json) fromJson) async {
    String tableName = ReflectionService.instance.getTableName<T>();
    int offset = (page - 1) * pageSize;
    List<Map<String, dynamic>> result = await _database.query(
      tableName,
      limit: pageSize,
      offset: offset,
    );
    return result.map((e) => fromJson(e)).toList();
  }

}