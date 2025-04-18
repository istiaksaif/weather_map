import 'package:get_storage/get_storage.dart';

const kSavedLocation = "saved_location";

class SessionManager {
  static GetStorage _preferences = GetStorage();

  static Future init() async => _preferences = GetStorage();

  static setValue(String key, dynamic value) {
    _preferences.write(key, value);
  }

  static dynamic getValue(String key, {dynamic value}) {
    return _preferences.read(key) ?? value;
  }

  static dynamic removeValue(String key) {
    return _preferences.remove(key);
  }

}
