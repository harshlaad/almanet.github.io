import 'package:app/services/local_db/auth_db.dart';
import 'package:app/services/local_db/basic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Db {
  static late SharedPreferences pref;
  static void onInit(SharedPreferences preferences) {
    pref = preferences;
  }

  static void clear() {
    pref.clear();
  }

  static Auth auth = Auth();
  static Basic basic = Basic();
}
