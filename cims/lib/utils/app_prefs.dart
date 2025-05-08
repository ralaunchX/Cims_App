import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static final AppPrefs _instance = AppPrefs._internal();
  factory AppPrefs() => _instance;

  SharedPreferences? prefs;

  AppPrefs._internal();

  Future<AppPrefs> init() async {
    prefs ??= await SharedPreferences.getInstance();
    return this;
  }

  String? getString(String key) {
    if (prefs == null) throw Exception('Prefs not initialized');
    return prefs!.getString(key);
  }

  Future<void> setString(String key, String value) async {
    if (prefs == null) throw Exception('Prefs not initialized');
    await prefs!.setString(key, value);
  }

  Future<void> setRapId(String id) async {
    await prefs!.setString('rap_id', id);
  }

  Future<void> setInterviewerName(String name, String rapId) async {
    await prefs!.setString('${rapId}_interviewername', name);
  }

  String? getRapId() => prefs?.getString('rap_id');
  String? getInterviewerName(String rapId) =>
      prefs?.getString('${rapId}_interviewername');
}
