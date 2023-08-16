import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifieasy/account_selection.dart';
import 'package:wifieasy/main.dart';


class AddAccountScreen extends StatefulWidget {
  AddAccountScreen({super.key});

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  final TextEditingController registrationController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool registrationValidation = false;
  bool passwordValidation = false;

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add Account",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 115, 115, 115)),
          ),
          backgroundColor: Color.fromARGB(255, 28, 28, 28),
        ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: registrationController,
              decoration: InputDecoration(
                hintText: "Registration Number",
                errorText: registrationValidation ? "Username cannot be empty" : null,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,)
                )
              ),
            style: TextStyle(color: const Color.fromARGB(255, 32, 32, 32)),
            maxLines: 1,
          ),)),
          Flexible(
            child: Container(
              child: TextField(
                controller: passwordController,
                obscureText: !showPassword,
              decoration: InputDecoration(
                hintText: "Password",
                errorText: passwordValidation ? "Password cannot be empty" : null,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,)
                )
              ),
            style: TextStyle(color: const Color.fromARGB(255, 32, 32, 32)),
            maxLines: 1,
          ),)),
          Container(
            child: Row(
            children: [
            Checkbox(value: showPassword, onChanged: (value) {
              setState(() {
                showPassword = value ?? false;
              });
            }),
            Text(
              "Show Password"
            )
          
          ]),
          )
          ,
          Container(
            width: double.infinity,
            child: TextButton(
            onPressed: () async {

              String registrationNumber = registrationController.text;
              String passwordText = passwordController.text;

              if (registrationNumber == "" || passwordText == "") {
                
                setState(() {
                  registrationValidation = registrationNumber == "";
                  passwordValidation = passwordText == "";
                });

                return;
              }

              String finalStore = registrationNumber + "=" + passwordText;

              print(finalStore);
              print(finalStore.split("="));

              final prefs = await SharedPreferences.getInstance();

              List<String>? values = prefs.getStringList("USERS");

              if (values == null) {

                prefs.setStringList("USERS", [
                  finalStore
                ]);
              }
              else {
                values.add(finalStore);
                prefs.setStringList("USERS", values);
              }
              Get.offAllNamed("/account_selection");

            }, child: Text("Submit"),
            style: TextButton.styleFrom(
              fixedSize: Size(1000, 55),
              foregroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Color.fromARGB(255, 87, 209, 91))

              )
            )
            
          ),
          )
        ],
      ),
      )
    );
  }
}
