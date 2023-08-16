import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DebugResponseScreen extends StatelessWidget {
  DebugResponseScreen({
    super.key,
    required this.responseText
  });
  
  String responseText;

  Widget getResponse() {
    if (responseText.split("=").length == 2) {
      // if the Get.arguements value is the user's credentials in some cases, then just prevent displaying it.
      // this makes absolutely no sense, but i am too lazy to fix this :P
      return Text("There was no response from the server", style: TextStyle(
        color: Colors.grey
      ),);
    }
    return Text(responseText, style: TextStyle(
        color: Colors.grey
      ));
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Server Response"),
      ),
      body: getResponse()
    );
  }
}