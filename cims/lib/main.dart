import 'package:cims/census.dart';
import 'package:cims/food_forms.dart';
import 'package:cims/form_list.dart';
import 'package:cims/household_info_screens.dart/llwdsp_householdcomposition_screen.dart';
import 'package:cims/household_info_screens.dart/llwdsp_householdeducation_screen.dart';
import 'package:cims/household_info_screens.dart/llwdsp_householdemployment_screen.dart';
import 'package:cims/household_info_screens.dart/llwdsp_skillknowledge_screen.dart';
import 'package:cims/household_info_screens.dart/llwdsp_smallbusiness_screen.dart';
import 'package:cims/household_info_screens.dart/llwdsp_unemployment_screen.dart';
import 'package:cims/household_list.dart';
import 'package:cims/llwdsp_assets_screen.dart';
import 'package:cims/llwdsp_cropfield_screen.dart';
import 'package:cims/llwdsp_energysources_screen.dart';
import 'package:cims/llwdsp_expenditure_screen.dart';
import 'package:cims/llwdsp_foodgardens_screen.dart';
import 'package:cims/llwdsp_foodmontly_screen.dart';
import 'package:cims/llwdsp_foodproductionconsumption_screen.dart';
import 'package:cims/llwdsp_foodsecurity_screens.dart';
import 'package:cims/llwdsp_fruittrees_screen.dart';
import 'package:cims/llwdsp_funding_screen.dart';
import 'package:cims/llwdsp_householdadditionalinfo_scree.dart';
import 'package:cims/llwdsp_livelihood_screen.dart';
import 'package:cims/llwdsp_livestock_screen.dart';
import 'package:cims/llwdsp_resettlement_screen.dart';
import 'package:cims/llwdsp_socialnetwork_screen.dart';
import 'package:cims/llwdsp_transport_screen.dart';
import 'package:cims/login.dart';
import 'package:cims/rap_create.dart';
import 'package:cims/rap_list.dart';
import 'package:cims/utils/app_prefs.dart';
import 'package:cims/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await AppPrefs().init();
  final String route = await checkLogin();

  runApp(MainApp(initialRoute: route));
}

Future<String> checkLogin() async {
  final prefs = await SharedPreferences.getInstance();
  final expiryMillis = prefs.getInt(Keys.loginExpiryTimestamp);
  final nowMillis = DateTime.now().millisecondsSinceEpoch;

  if (expiryMillis != null && expiryMillis > nowMillis) {
    return '/rapList';
  } else {
    return '/login';
  }
}

class MainApp extends StatelessWidget {
  final String initialRoute;

  const MainApp({super.key, required this.initialRoute});

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
          '/llwdspResettlement': (context) => const LlwdspResettlement(),
          '/llwdspAssets': (context) => const LlwdspAssetsScreen(),
          '/llwdspLivelihood': (context) => const LlwdspLivelihood(),
          '/llwdspSocialNetwork': (context) =>
              const LlwdspSocialnetworkScreen(),
          '/llwdspFoodGardens': (context) => const LlwdspFoodgardensScreen(),
          '/llwdspCropField': (context) => const LlwdspCropfieldScreen(),
          '/llwdspLivestock': (context) => const LlwdspLivestockScreen(),
          '/llwdspFruitTrees': (context) => const LlwdspFruitTressScreen(),
          '/llwdspExpenditure': (context) => const LlwdspExpenditureScreen(),
          '/llwdspTransport': (context) => const LlwdspTransportScreen(),
          '/llwdspFunding': (context) => const LlwdspFundingScreen(),
          '/houseHold': (context) => const HouseholdList(),
          '/llwdspHouseholdComposition': (context) =>
              const LlwdspHouseholdcompositionScreen(),
          '/llwdspHouseholdEducation': (context) =>
              const LlwdspHouseholdEducationScreen(),
          '/llwdspHouseholdEmployment': (context) =>
              const LlwdspHouseholdEmploymentScreen(),
          '/llwdspHouseholdUnEmployment': (context) =>
              const LlwdspHouseholdUnEmploymentScreen(),
          '/llwdspHouseholdSkillKnowledge': (context) =>
              const LlwdspSkillKnowledgeScreen(),
          '/llwdspHouseholdSmallBusiness': (context) =>
              const LlwdspBusinessScreen(),
          '/llwdspEnergySources': (context) =>
              const LlwdspEnergysourcesScreen(),
          '/llwdspAdditionalInfo': (context) =>
              const LlwdspHouseholdadditionalinfoScreen(),
          '/llwdspFoodForms': (context) => const FoodFormsScreen(),
          '/llwdspFoodSecurity': (context) => const LlwdspFoodsecurityScreens(),
          '/llwdspFoodMonthlyStatus': (context) =>
              const LlwdspFoodMontlyScreen(),
          '/llwdspFoodProductionConsumpion': (context) =>
              const LlwdspFoodproductionconsumption(),
        },
        // theme: ThemeData(
        //   inputDecorationTheme: const InputDecorationTheme(
        //     contentPadding:
        //         EdgeInsets.symmetric(vertical: 30.0, horizontal: 12.0),
        //     labelStyle: TextStyle(fontSize: 20),
        //     border: OutlineInputBorder(),
        //   ),
        //   textTheme: const TextTheme(
        //     bodyMedium: TextStyle(fontSize: 16),
        //   ),
        // ),
        initialRoute: initialRoute);
  }
}
