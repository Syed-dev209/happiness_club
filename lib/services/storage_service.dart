import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:happiness_club/constants/storage_keys.dart';

class StorageServices {
  static StorageServices _services = StorageServices._internal();
  factory StorageServices() {
    return _services;
  }
  StorageServices._internal();

  final box = GetStorage();

  writeDataToStorage(String key, dynamic value) {
    box.write(key, value);
  }

  dynamic readDataFromStorage(String key) {
    var data = box.read(key) ?? "";
    return data;
  }

  deleteDataFromStorage(String key) {
    box.remove(key);
  }

  clearAllData() {
    List<String> val = box.getKeys().toList();
    for (var i in val) {
      if (i != StorageKeys.REGISTERED) {
        box.remove(i);
      }
    }
  }
}
