import 'dart:convert';

import 'package:cims/data_model/resettlement_llwdsp.dart';
import 'package:cims/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static String baseUrl = AppConstants.devUrl;

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
}
