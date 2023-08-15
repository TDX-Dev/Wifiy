import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        GetPage(name: "/login_screen", page: () => LoginScreen())
      
      ],
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

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
                    future: getAccountDetails(),
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
                        return Text("Bye World");
                      }
                    }),
              )
            ],
          ),
        ));
  }
}

Future<List<Widget>> getAccountDetails() async {
  final val = await SharedPreferences.getInstance();

  final pair = val.getStringList("USERS");
  List<Widget> r = [];

  if (pair == null) return [Text("Unavailable")];

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
            ),),
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black), color: Colors.red.shade200),
              child: IconButton(
                onPressed: () async {
                  final index = i;
                  
                  final val = await SharedPreferences.getInstance();

                  final pair = val.getStringList("USERS")!;

                  pair.removeAt(index);

                  val.setStringList("USERS", pair);

                  Get.offAll(MyHome());

                },
                icon: Icon(Icons.delete),
              ),
            )
          ]),
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 228, 228, 228),
        borderRadius: BorderRadius.circular(5),
      ),
    ));
  }
  return r;
}
