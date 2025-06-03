import 'package:cims/utils/api_services.dart';
import 'package:cims/utils/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Upload {
  static Future<void> uploadForms({required String rapId}) async {
    print(rapId);

    final prefs = await SharedPreferences.getInstance();

    final allKeys = prefs.getKeys();

    List<String> keyList = [];
    for (final key in allKeys) {
      if (key.startsWith('${rapId}_')) {
        keyList.add(key);
      }
    }
    print(keyList);
    for (String key in keyList) {
      try {
        if (key == '${rapId}_interviewername') {
          print('interviewer');
        } else if (key == '${rapId}_${Keys.llwdspResettlement}') {
          var res =
              await ApiServices.form31Resettlement(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspAssets}') {
          var res =
              await ApiServices.form33Assets(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        }
      } catch (e) {
        print('Error uploading for key $key');
      }
    }
  }

  static Future<void> formUploadSuccess(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
