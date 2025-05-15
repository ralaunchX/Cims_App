import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:external_path/external_path.dart';
import 'package:path/path.dart' as p;

class Utility {
  static Future<String?> getCurrentCoordinates() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return '${position.latitude}, ${position.longitude}';
  }

  static Future<void> downloadJson(BuildContext context, String rapId) async {
    final prefs = await SharedPreferences.getInstance();

    final allKeys = prefs.getKeys();

    final status = await Permission.manageExternalStorage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Storage permission denied.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final downloadsPath =
          await ExternalPath.getExternalStoragePublicDirectory("Download");

      final Map<String, String> collectedMap = {};

      for (final key in allKeys) {
        if (key.startsWith(rapId) && !key.endsWith('interviewername')) {
          final jsonData = prefs.getString(key);
          if (jsonData == null) continue;

          collectedMap[key] = jsonData;
        }
      }

      if (collectedMap.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No form data for this rap id.'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      final combinedJson = encoder.convert(collectedMap);

      final filePath = p.join(downloadsPath, "$rapId.json");
      final file = File(filePath);
      await file.writeAsString(combinedJson);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Saved $rapId.json to Download folder.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  static Future<void> downloadCsv(BuildContext context, String prefix) async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getKeys();

    final status = await Permission.manageExternalStorage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Storage permission denied.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final downloadsPath =
          await ExternalPath.getExternalStoragePublicDirectory("Download");

      int savedFiles = 0;
      for (final key in allKeys) {
        if (key.startsWith(prefix) && !key.endsWith('interviewername')) {
          final jsonData = (prefs.getString(key));
          if (jsonData == null) continue;
          final decoded = jsonDecode(jsonData);
          if (decoded is Map<String, dynamic>) {
            final csv = convertJsonToCsv(decoded);
            final filePath = p.join(downloadsPath, "$key.csv");
            final file = File(filePath);
            await file.writeAsString(csv);
            savedFiles++;
          }
        }
      }

      if (savedFiles == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No matching data found.'),
            backgroundColor: Colors.orange,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Saved $savedFiles file(s) to Download folder.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving files: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  static String convertJsonToCsv(Map<String, dynamic> json) {
    final headers = json.keys.join(',');
    final values = json.values.map((e) => '"$e"').join(',');
    return '$headers\n$values';
  }

  static Future<String?> selectDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      return '${picked.day.toString().padLeft(2, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-'
          '${picked.year}';
    }
    return null;
  }
}
