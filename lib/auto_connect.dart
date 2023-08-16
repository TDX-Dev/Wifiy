import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutoConnectScreen extends StatefulWidget {
  bool enabled;
  List<String> accounts;
  int accountIndex = 0;

  AutoConnectScreen({super.key, required this.enabled, required this.accounts, required this.accountIndex});

  @override
  State<AutoConnectScreen> createState() => _AutoConnectScreenState();
}

class _AutoConnectScreenState extends State<AutoConnectScreen> {
  @override
  Widget build(BuildContext context) {

    List<DropdownMenuItem> dropDownItems = [];

    for (int i = 0; i < widget.accounts.length; i++) {
      String accountName = widget.accounts[i].split("=")[0];
      dropDownItems.add(
        DropdownMenuItem(
          child: Text(accountName),
          value: i,
        )
      );
    }

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shape: Border(bottom: BorderSide(color: Colors.grey, width: 2)),
          title: Text("Auto Connect [DEV]"),
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Colors.grey.shade200, width: 0.3))),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Status"),
                  Switch(
                      value: widget.enabled,
                      onChanged: (value) async {
                        final val = await SharedPreferences.getInstance();
                        final pref = val.setBool("auto_connect", value);
                        setState(() {
                          widget.enabled = value;
                        });
                      })
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Colors.grey.shade200, width: 0.3))),
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Autoconnect Account"),
                  AbsorbPointer(
                      absorbing: !widget.enabled,
                      child: DropdownButton(
                        isExpanded: true,
                        dropdownColor: Colors.black,
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'JetBrainsMono',
                          overflow: TextOverflow.fade
                        ),
                        value: widget.accountIndex,
                      onChanged: (value) async {
                        
                        final val = await SharedPreferences.getInstance();

                        val.setInt("auto_connect_account", value);

                        setState(() {
                          widget.accountIndex = value;  
                        });
                      },
                      items: dropDownItems
                    ),)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                  "This options ensures that you are connected and logged in to a VIT WiFi when nearby."),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              color: Colors.amber,
              child: Text(
                "[This is an experimental feature]\n [May or may not work]",
                textAlign: TextAlign.center,
              ),
            )
          ],
        ));
  }
}
