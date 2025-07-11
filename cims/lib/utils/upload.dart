import 'dart:convert';

import 'package:cims/utils/api_services.dart';
import 'package:cims/utils/app_prefs.dart';
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

    //logic to change temp keys
    if (rapId.startsWith('TEMP')) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? interviewerName = prefs.getString('${rapId}_interviewername');

      var response = await ApiServices.createRapId(
          interviewerName: interviewerName ?? 'N/A');
      int id = response['case_id'];
      String newRapId = id.toString();
      List<String> newKeyList = [];
      for (String oldKey in keyList) {
        String newKey = oldKey.replaceFirst('${rapId}_', '${newRapId}_');
        var value = prefs.get(oldKey);

        if (value is String) {
          try {
            Map<String, dynamic> jsonMap = jsonDecode(value);

            if (jsonMap.containsKey('case')) {
              jsonMap['case'] = newRapId;
            }

            String updatedJson = jsonEncode(jsonMap);
            await prefs.setString(newKey, updatedJson);
          } catch (e) {
            await prefs.setString(newKey, value);
          }
        } else if (value is int) {
          await prefs.setInt(newKey, value);
        } else if (value is bool) {
          await prefs.setBool(newKey, value);
        } else if (value is double) {
          await prefs.setDouble(newKey, value);
        } else if (value is List<String>) {
          await prefs.setStringList(newKey, value);
        }

        await prefs.remove(oldKey);

        newKeyList.add(newKey);
      }
      await AppPrefs().setRapId(newRapId);
      rapId = newRapId;
      keyList = newKeyList;
    }
    print(keyList);
    final now = DateTime.now();
    await prefs.setString(
        '${rapId}_${Keys.lastUploadTime}', now.toIso8601String());
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
        } else if (key == '${rapId}_${Keys.llwdspHouseholdEducation}') {
          var res = await ApiServices.form32Education(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspHouseholdEmployment}') {
          var res = await ApiServices.form32Employment(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspHouseholdUnEmployment}') {
          var res =
              await ApiServices.form32UnEmployment(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspHouseholdSkillKnowledge}') {
          var res =
              await ApiServices.form32SkillsKnowledge(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.llwdspHouseholdSmallBusiness}') {
          var res =
              await ApiServices.form32BusinessIncome(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.censusHousehold}') {
          var res = await ApiServices.censusHousehold(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.censusInstitution}') {
          var res = await ApiServices.censusInstitution(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.assetsHouseHold}') {
          var res = await ApiServices.assetHousehold1(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.assetDetails}') {
          var res = await ApiServices.assetDetails2(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.assetBeneficiary}') {
          var res = await ApiServices.assetBeneficiary3(rapId: rapId, key: key);
          if (res == true) {
            await formUploadSuccess(key);
          }
        } else if (key == '${rapId}_${Keys.assetCoowner}') {
          var res = await ApiServices.assetCoOwner4(rapId: rapId, key: key);
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
