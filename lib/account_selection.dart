import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountSelectionScreen extends StatefulWidget {
  const AccountSelectionScreen({super.key});

  @override
  State<AccountSelectionScreen> createState() => _AccountSelectionScreenState();
}

class _AccountSelectionScreenState extends State<AccountSelectionScreen> {
  void reloadWidgets() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: Colors.white70,
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            print(prefs.getStringList("USERS"));
            Get.toNamed("/add_account");
          },
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        drawer: NavigationDrawer(children: [
          Container(
            child: Text("Options", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),
            ),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black))
            ),
          ),
          InkWell(
            child: Container(
              color: const Color.fromARGB(88, 158, 158, 158),
              padding: EdgeInsets.all(10),
              child: Text("Auto Connect"),
            ),
            onTap: () {},
          )
        ]),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Account Selection",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 115, 115, 115)),
          ),
          backgroundColor: Color.fromARGB(255, 227, 227, 227),
        ),
        body: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Flexible(
                child: FutureBuilder(
                    future: getAccountDetails(reloadWidgets),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data!.length > index) {
                              return snapshot.data![index];
                            }
                          },
                        );
                      } else {
                        return Text("No Account Registered");
                      }
                    }),
              )
            ],
          ),
        ));
  }
}

Future<List<Widget>> getAccountDetails(Function reloadFunction) async {
  final val = await SharedPreferences.getInstance();

  final pair = val.getStringList("USERS");
  List<Widget> r = [];

  if (pair == null || pair.length == 0)
    return [
      Container(
        padding: EdgeInsets.all(20),
        child: Text(
          "No account registered.",
          style: TextStyle(color: Colors.black),
        ),
      )
    ];

  for (int i = 0; i < pair!.length; i++) {
    final username = pair[i].split("=")[0];

    r.add(Container(
      height: 75,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          Get.toNamed("/login_screen", arguments: pair[i]);
        },
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  username,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red.shade200)),
                child: IconButton(
                  onPressed: () async {
                    final index = i;

                    final val = await SharedPreferences.getInstance();

                    final pair = val.getStringList("USERS")!;

                    pair.removeAt(index);

                    val.setStringList("USERS", pair);

                    reloadFunction();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red.shade200,
                  ),
                ),
              )
            ]),
      ),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 228, 228, 228),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black)),
    ));
  }
  return r;
}
