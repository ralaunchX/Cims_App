import 'package:cims/census.dart';
import 'package:cims/form_list.dart';
import 'package:cims/login.dart';
import 'package:cims/rap_create.dart';
import 'package:cims/rap_list.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await AppPrefs().init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginPage(),
        '/rapId': (context) => const RapIdEntryScreen(),
        '/formlist': (context) => const FormListScreen(),
        '/census': (context) => const CensusFormsScreen(),
        '/rapList': (context) => const RapListScreen(),
      },
      initialRoute: '/login',
    );
  }
}
