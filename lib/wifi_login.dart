import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wifieasy/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String login = Get.arguments;
  bool loginState = false;

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
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            padding: EdgeInsets.all(20),
          ),
          Container(
            margin: EdgeInsets.all(20),
            height: 64,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green.shade200),
                borderRadius: BorderRadius.circular(10)
            ),
            child: InkWell(
              child: Icon(Icons.power, color: Colors.green.shade200,),
              hoverColor: Colors.transparent,
              onTap: () async {
                print("LOGIN");

                final username = login.split("=")[0];
                final password = login.split("=")[1];

                print(jsonEncode(
                    <String, String> {
                      'userId': username,
                      'password': password,
                      'serviceName' : 'ProntoAuthentication',
                      'Submit22': 'Login'
                    }
                  ));

                  final response = await http.post(
                    Uri.parse("http://phc.prontonetworks.com/cgi-bin/authlogin?URI=http://www.msftconnecttest.com/redirect"),
                    body: {
                      'userId': username,
                      'password': password,
                      'serviceName' : 'ProntoAuthentication',
                      'Submit22': 'Login'
                    }
                  );

              },
            )),
        ],)
      ),
    );
  }
}
