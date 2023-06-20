import 'package:app/services/local_db/local_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Basic {
  static final SharedPreferences _pref = Db.pref;

  void setRoasterId(String id) => _pref.setString("roasterId", id);
  String getRoasterId() => _pref.getString("roasterId") ?? "";
}
