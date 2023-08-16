import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifieasy/account_selection.dart';
import 'package:wifieasy/add_account.dart';
import 'package:wifieasy/wifi_login.dart';

void main() {
  //SharedPreferences.setMockInitialValues({});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
              titleMedium:
                  TextStyle(color: Colors.white, fontFamily: 'JetBrainsMono'),
              bodyMedium: TextStyle(
                  color: const Color.fromARGB(255, 104, 104, 104),
                  fontFamily: 'JetBrainsMono'),
              bodyLarge:
                  TextStyle(color: Colors.white, fontFamily: 'JetBrainsMono'),
              titleLarge:
                  TextStyle(color: Colors.white, fontFamily: 'JetBrainsMono'))),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: "/add_account", page: () => AddAccountScreen()),
        GetPage(name: "/login_screen", page: () => LoginScreen()),
        GetPage(name: "/account_selection", page: () => AccountSelectionScreen())
      
      ],
      home: AccountSelectionScreen(),
    );
  }
}
