import 'package:hive/hive.dart';

class HiveHelper {
  static Box? box;

  static init() async {
    box = await Hive.openBox("myList");
     
  }

  static Future<void> saveData({required dynamic key ,required dynamic value}) {
    return box!.put(key,value);
  }

  static Future<int> addData({required dynamic value}) {
    return box!.add(value);
  }

  static dynamic getData({required dynamic key}) {
    return box!.get(key);
  }

  static Future<void> putData({required dynamic key, required dynamic value}) {
    return box!.put(key, value);
  }

  static Future<void> deleteData({ dynamic key})  {
    return box!.delete(key);
  }
}
