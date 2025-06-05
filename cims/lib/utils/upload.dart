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
          var res = await ApiServices.form33Assets(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspLivelihood}') {
          var res = await ApiServices.form34Livelihood(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspSocialNetwork}') {
          var res1 = await ApiServices.form35Social(
              rapId: rapId, key: key, questionNumber: 7);
          var res2 = await ApiServices.form35Social(
              rapId: rapId, key: key, questionNumber: 8);
          if (res1 == true && res2 == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspFoodGardens}') {
          var res = await ApiServices.form36FoodGardens(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspCropField}') {
          var res = await ApiServices.form37CropField(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspLivestock}') {
          var res = await ApiServices.form38LiveStock(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspFruitTrees}') {
          var res = await ApiServices.form39FruitTree(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspExpenditure}') {
          var res =
              await ApiServices.form310FExpenditure(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspTransport}') {
          var res = await ApiServices.form311Transport(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspFunding}') {
          var res = await ApiServices.form312Funding(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspEnergySources}') {
          var res = await ApiServices.form314Energy(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspAdditionalInfo}') {
          var res =
              await ApiServices.form315AdditionalInfo(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspFoodSecurity}') {
          var res =
              await ApiServices.form313FoodSecurity(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspFoodMonthlyStatus}') {
          var res =
              await ApiServices.form313MonthlyStatus(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspFoodProductionConsumpion}') {
          var res = await ApiServices.form313FoodProductionConsumption(
              rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspHouseholdComposition}') {
          var res = await ApiServices.form32HouseholdComposition(
              rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        }
        else if (key == '${rapId}_${Keys.llwdspHouseholdEducation}') {
          var res = await ApiServices.form32Education(
              rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        }
         else if (key == '${rapId}_${Keys.llwdspHouseholdEmployment}') {
          var res = await ApiServices.form32Employment(
              rapId: rapId, key: key);
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
