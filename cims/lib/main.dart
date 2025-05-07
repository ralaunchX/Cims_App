import 'package:cims/census.dart';
import 'package:cims/form_list.dart';
import 'package:cims/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LoginPage(),
        '/formlist': (context) => const FormListScreen(),
        '/census': (context) => const CensusFormsScreen(),
      },
      initialRoute: '/formlist',
    );
  }
}
