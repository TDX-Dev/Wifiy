import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wifieasy/Utils/network_utils.dart';
import 'package:wifieasy/account_selection.dart';
import 'package:wifieasy/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String login = Get.arguments;
  int loginState = 0;
  bool redirecting = false;

  Color getStateColor() {
    switch (loginState) {
      case 0:
        return Colors.green.shade200;
      case 1:
        return Colors.green.shade200;
      case 2:
        return Colors.orange.shade200;
      case 3:
        return Colors.red.shade200;
      default:
        return Colors.yellow.shade200;
    }
  }

  Widget getStateIcon() {
    switch (loginState) {
      case 0:
        return Icon(
          Icons.power,
          color: getStateColor(),
        );
      case 1:
        return Icon(
          Icons.check,
          color: getStateColor(),
        );
      case 2:
        return Icon(
          Icons.more_horiz,
          color: getStateColor(),
        );
      case 3:
        return Icon(
          Icons.close,
          color: getStateColor(),
        );
      default:
        return Icon(
          Icons.power,
          color: getStateColor(),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "One Click Login",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 115, 115, 115)),
        ),
        backgroundColor: Color.fromARGB(255, 3, 3, 3),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              "Are you trying to login?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            padding: EdgeInsets.all(20),
          ),
          Container(
              margin: EdgeInsets.all(20),
              height: 64,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: getStateColor()),
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                child: getStateIcon(),
                hoverColor: Colors.transparent,
                onTap: () async {
                  
                  if (redirecting) {return;}
                  final username = login.split("=")[0];
                  final password = login.split("=")[1];

                  print(jsonEncode(<String, String>{
                    'userId': username,
                    'password': password,
                    'serviceName': 'ProntoAuthentication',
                    'Submit22': 'Login'
                  }));

                  final loginSuccess = NetworkUtils.SendLoginRequest(username, password);
                  loginSuccess.then((value) {
                    if (value) {
                      setState(() {
                        loginState = 1;
                        redirecting = true;
                        Future.delayed(
                            Duration(seconds: 2), () => {Get.offAllNamed("/account_selection")});
                      });
                    } else {
                      setState(() {
                        loginState = 3;
                      });
                    }
                  });
                  setState(() {
                    loginState = 2;
                  });
                },
              )),
        ],
      )),
    );
  }
}
