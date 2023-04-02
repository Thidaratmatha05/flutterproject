import 'package:flutter/material.dart';
import 'package:flutterproject/screen/edit_item_screen.dart';
import 'package:flutterproject/screen/new_item_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterproject/screen/show_iten2.dart';
import '../firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ShowScore());
}

class ShowScore extends StatelessWidget {
  const ShowScore({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}

class ShowScoreScreen extends StatefulWidget {
  const ShowScoreScreen({super.key, required this.title});
  final String title;

  @override
  State<ShowScoreScreen> createState() => _ShowScoreScreenState();
}

class _ShowScoreScreenState extends State<ShowScoreScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("items").snapshots(),
        builder: ((context, snapshot) {
          final dataDocuments = snapshot.data?.docs;
          if (dataDocuments == null) return const Text("No data");
          return ListView.builder(
            itemCount: dataDocuments.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dataDocuments[index]["itemCode"].toString()),
                subtitle: Text(dataDocuments[index]["itemScore"].toString()),
                onTap: () => _ShowScoreScreen(
                    dataDocuments[index].id,
                    dataDocuments[index]["itemCode"],
                    dataDocuments[index]["itemName"],
                    dataDocuments[index]["itemEmail"],
                    dataDocuments[index]["itemScore"],
                ),
              );
            },
          );
        }),
      ),
    );

  }

  void _ShowScoreScreen(String documentid, String itemCode, String itemName,
      String itemEmail, String itemScore) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShowScoreScreen2(
                documentid, itemCode, itemName, itemEmail, itemScore, title: '',)));
  }
}
