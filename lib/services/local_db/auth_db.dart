import 'dart:convert';

import 'package:app/services/local_db/local_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static final SharedPreferences _pref = Db.pref;

  void setAuthorisation(Map<String, dynamic> map) =>
      _pref.setString("authorisation", jsonEncode(map));
  Map<String, dynamic>? getAuthorisation() =>
      _pref.getString("authorisation") == null
          ? null
          : jsonDecode(_pref.getString("authorisation")!);

  void setRemeber(bool value) => _pref.setBool("remember", value);
  bool getRemeber() => _pref.getBool("remember") ?? false;

  void setUser(Map<String, dynamic> user) =>
      _pref.setString("user", jsonEncode(user));
  Map<String, dynamic>? getUser() {
    String? data = _pref.getString("user");
    if (data == null) {
      return null;
    } else {
      return jsonDecode(data);
    }
  }

  void setProfile(Map<String, dynamic> profile) =>
      _pref.setString("profile", jsonEncode(profile));
  Map<String, dynamic>? getProfile() {
    String? data = _pref.getString("profile");
    if (data == null) {
      return null;
    } else {
      return jsonDecode(data);
    }
  }

  void setforgetMobile(String mobile) =>
      _pref.setString("forgetMobile", mobile);
  String? getForgetMobile() => _pref.getString("forgetMobile");

  void setUserId(int userId) => _pref.setInt("userId", userId);
  int? getUserId() => _pref.getInt("userId");
}
