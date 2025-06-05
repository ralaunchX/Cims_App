import 'dart:convert';
import 'dart:developer';
import 'package:logger/logger.dart';

import 'package:cims/data_model/llwdsp_social_network_model.dart';
import 'package:cims/data_model/resettlement_llwdsp.dart';
import 'package:cims/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static String baseUrl = AppConstants.devUrl;

  static final logger = Logger();

  static Map<String, String> _getHeaders() {
    return {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer $bearerToken',
    };
  }

  Future<void> interviewerUpdate(
      {required String rapId, required String name}) async {
    final url = Uri.parse('$baseUrl/');
    final body = {};

    try {
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {}
      throw Exception(
        'Error: ${response.statusCode} - ${response.reasonPhrase}',
      );
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<dynamic> form31Resettlement({
    required String rapId,
    required String key,
  }) async {
    final url = Uri.parse('$baseUrl/lldp-general-info/create/');
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);

    if (jsonData == null) {
      throw Exception('No saved data found for key: $key');
    }

    try {
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: jsonData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          'Error: ${response.statusCode} - ${response.reasonPhrase}\n${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error posting form: $e');
    }
  }

  static Future<dynamic> form33Assets({
    required String rapId,
    required String key,
  }) async {
    final url = Uri.parse('$baseUrl/household-assets/create/');
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);

    if (jsonData == null) {
      throw Exception('No saved data found for key: $key');
    }

    try {
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: jsonData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          'Error: ${response.statusCode} - ${response.reasonPhrase}\n${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error posting form: $e');
    }
  }

  static Future<dynamic> form34Livelihood({
    required String rapId,
    required String key,
  }) async {
    final url = Uri.parse('$baseUrl/livelihood-resources/create/');
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);

    if (jsonData == null) {
      throw Exception('No saved data found for key: $key');
    }

    try {
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: jsonData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          'Error: ${response.statusCode} - ${response.reasonPhrase}\n${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error posting form: $e');
    }
  }

  static Future<dynamic> form35Social(
      {required String rapId,
      required String key,
      required int questionNumber}) async {
    final url = Uri.parse('$baseUrl/social-network/create/');
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);

    if (jsonData == null) {
      throw Exception('No saved data found for key: $key');
    }
    LlwdspSocialNetworkModel socialData =
        LlwdspSocialNetworkModel.fromJson(jsonDecode(jsonData));
    var payload = {};
    if (questionNumber == 7) {
      payload = {
        "household_giving_support": socialData.givingSupportCategory,
        "frequency": socialData.givingSupportFrequency,
        "relation_to_supported_Household": socialData.givingSupportRelation,
        "case": rapId,
        "common_question": questionNumber
      };
    } else if (questionNumber == 8) {
      payload = {
        "frequency": socialData.receivingSupportFrequency,
        "relation_to_supported_Household": socialData.receivingSupportRelation,
        "household_receiving_support": socialData.receivingSupportCategory,
        "case": rapId,
        "common_question": questionNumber
      };
    }
    try {
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        logger.e(
          'Error: ${response.statusCode} - ${response.reasonPhrase}\n${response.body}',
        );
        return false;
      }
    } catch (e) {
      throw Exception('Error posting form: $e');
    }
  }

  static Future<dynamic> form36FoodGardens({
    required String rapId,
    required String key,
  }) async {
    final url = Uri.parse('$baseUrl/food-garden/create/');
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);

    if (jsonData == null) {
      throw Exception('No saved data found for key: $key');
    }

    try {
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: jsonData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          'Error: ${response.statusCode} - ${response.reasonPhrase}\n${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error posting form: $e');
    }
  }

  static Future<dynamic> form37CropField({
    required String rapId,
    required String key,
  }) async {
    final url = Uri.parse('$baseUrl/cropfields/');
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);

    if (jsonData == null) {
      throw Exception('No saved data found for key: $key');
    }

    try {
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: jsonData,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          'Error: ${response.statusCode} - ${response.reasonPhrase}\n${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error posting form: $e');
    }
  }

  static Future<dynamic> form38LiveStock({
    required String rapId,
    required String key,
  }) async {
    final url = Uri.parse('$baseUrl/livestock-details/');
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);

    if (jsonData == null) {
      throw Exception('No saved data found for key: $key');
    }

    try {
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: jsonData,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          'Error: ${response.statusCode} - ${response.reasonPhrase}\n${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error posting form: $e');
    }
  }

  static Future<dynamic> form39FruitTree({
    required String rapId,
    required String key,
  }) async {
    final url = Uri.parse('$baseUrl/fruit-tree-details/');
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);

    if (jsonData == null) {
      throw Exception('No saved data found for key: $key');
    }
    final Map<String, dynamic> parsed = jsonDecode(jsonData);
    final caseId = int.parse(parsed['case'].toString());
    final List<Map<String, dynamic>> result =
        (parsed['trees'] as List).map<Map<String, dynamic>>((tree) {
      return {
        'case': caseId,
        'tree_type': tree['tree_type'],
        'number': tree['number'],
        'use': tree['use'],
      };
    }).toList();

    final String payload = jsonEncode(result);
    try {
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: payload,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          'Error: ${response.statusCode} - ${response.reasonPhrase}\n${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error posting form: $e');
    }
  }

  static Future<dynamic> form310FExpenditure({
    required String rapId,
    required String key,
  }) async {
    final url = Uri.parse('$baseUrl/expenditure/');
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);

    if (jsonData == null) {
      throw Exception('No saved data found for key: $key');
    }
    final Map<String, dynamic> parsed = jsonDecode(jsonData);
    final caseId = int.parse(parsed['case'].toString());
    final List<Map<String, dynamic>> result =
        (parsed['expenditureList'] as List).map<Map<String, dynamic>>((item) {
      return {
        'case': caseId,
        'expenditure_item': item['expenditure_item'],
        'frequency': item['frequency'],
        'last_month': item['last_month'],
      };
    }).toList();

    final String payload = jsonEncode(result);
    try {
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: payload,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          'Error: ${response.statusCode} - ${response.reasonPhrase}\n${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error posting form: $e');
    }
  }

  static Future<dynamic> form311Transport({
    required String rapId,
    required String key,
  }) async {
    final url = Uri.parse('$baseUrl/transport/');
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);

    if (jsonData == null) {
      throw Exception('No saved data found for key: $key');
    }

    try {
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: jsonData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          'Error: ${response.statusCode} - ${response.reasonPhrase}\n${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error posting form: $e');
    }
  }

  static Future<dynamic> form312Funding({
    required String rapId,
    required String key,
  }) async {
    final url = Uri.parse('$baseUrl/savings-club/');
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);

    if (jsonData == null) {
      throw Exception('No saved data found for key: $key');
    }
    final Map<String, dynamic> parsed = jsonDecode(jsonData);

    final caseId = int.parse(parsed['case'].toString());
    final List<Map<String, dynamic>> result = (parsed['fundingData'] as List)
        .map((e) => {
              ...Map<String, dynamic>.from(e),
              'case': caseId,
            })
        .toList();

    final String payload = jsonEncode(result);

    try {
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: payload,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          'Error: ${response.statusCode} - ${response.reasonPhrase}\n${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error posting form: $e');
    }
  }

  static Future<dynamic> form314Energy({
    required String rapId,
    required String key,
  }) async {
    final url = Uri.parse('$baseUrl/energy-sources/');
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);

    if (jsonData == null) {
      throw Exception('No saved data found for key: $key');
    }
    final Map<String, dynamic> parsedData = jsonDecode(jsonData);

    final List<Map<String, dynamic>> listData = [parsedData];

    final String jsonString = jsonEncode(listData);

    try {
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: jsonString,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          'Error: ${response.statusCode} - ${response.reasonPhrase}\n${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error posting form: $e');
    }
  }

  static Future<dynamic> form315AdditionalInfo({
    required String rapId,
    required String key,
  }) async {
    final url = Uri.parse('$baseUrl/resettlement-surveys/');
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);

    if (jsonData == null) {
      throw Exception('No saved data found for key: $key');
    }

    try {
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: jsonData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          'Error: ${response.statusCode} - ${response.reasonPhrase}\n${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error posting form: $e');
    }
  }

  static Future<dynamic> form313FoodSecurity({
    required String rapId,
    required String key,
  }) async {
    final url = Uri.parse('$baseUrl/food-security/');
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);

    if (jsonData == null) {
      throw Exception('No saved data found for key: $key');
    }

    try {
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: jsonData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          'Error: ${response.statusCode} - ${response.reasonPhrase}\n${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error posting form: $e');
    }
  }

  static Future<dynamic> form313MonthlyStatus({
    required String rapId,
    required String key,
  }) async {
    final url = Uri.parse('$baseUrl/monthly-food-status/');
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);

    if (jsonData == null) {
      throw Exception('No saved data found for key: $key');
    }

    try {
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: jsonData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          'Error: ${response.statusCode} - ${response.reasonPhrase}\n${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error posting form: $e');
    }
  }

  static Future<dynamic> form313FoodProductionConsumption({
    required String rapId,
    required String key,
  }) async {
    final url = Uri.parse('$baseUrl/food-production/');
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);

    if (jsonData == null) {
      throw Exception('No saved data found for key: $key');
    }
    print(jsonData);
    try {
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: jsonData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(
          'Error: ${response.statusCode} - ${response.reasonPhrase}\n${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error posting form: $e');
    }
  }
}
