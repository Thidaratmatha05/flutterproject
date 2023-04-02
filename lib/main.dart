import 'package:flutterproject/screen/login_screen.dart';
import 'package:flutterproject/services/auth_service.dart';
import 'package:flutterproject/services/item_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

// New Team Page

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutterproject/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutterproject/screen/new_item_screen.dart';
import 'package:flutterproject/screen/edit_item_screen.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Project Score',
      theme: ThemeData(
         primarySwatch: Colors.blueGrey,
      ),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthService _service = AuthService();

  @override
  Widget build(BuildContext context) {
    // setup req data user email
    User? currentUser = _service.user;
    String displayEmail = "";
    if (currentUser != null && currentUser.email != null) {
      displayEmail = currentUser.email!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color.fromARGB(255, 221, 240, 255)),
            child: Text("Welcome : $displayEmail"),
          ),
          ListTile(
            title: const Text("Logout"),
            onTap: () {
              _service.logout(currentUser);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
            }
            // call logout()
            // redirect to login page
            ,
          )
        ],
      )),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("items").snapshots(),
        builder:
            ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final dataDocuments = snapshot.data?.docs;
          if (dataDocuments == null) {return const Text("No data");}

          return ListView.builder(
            itemCount: dataDocuments.length,
            itemBuilder: (context, index) {
              return Builder(builder: (context) {
                return ListTile(
                  title: Text(dataDocuments[index]["itemCode"]),
                  subtitle: Row(
                    children: [
                      Text(dataDocuments[index]["itemName"]),
                    ],
                  ),
                  onTap: () => _editItemScreen(
                    dataDocuments[index].id,
                    dataDocuments[index]["itemCode"],
                    dataDocuments[index]["itemName"],
                    dataDocuments[index]["itemEmail"],
                    dataDocuments[index]["itemScore"],
                  ),
                );
              });
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewItem,
        tooltip: 'Create New Item',
        backgroundColor: Color.fromARGB(255, 0, 187, 255),
        child: const Icon(Icons.add),
       
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _createNewItem() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewItemScreen()));
  }

  void _editItemScreen(String documentid, String itemCode, String itemName,
      String itemEmail, String itemScore) {
    Navigator.push( context, MaterialPageRoute(
            builder: (context) => EditItemScreen(
                documentid, itemCode, itemName, itemEmail, itemScore)));
  }
}
