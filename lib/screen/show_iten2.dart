
import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/services/item_service.dart';

class ShowScoreScreen2 extends StatefulWidget {
  // Definde Object to get data
  ShowScoreScreen2(this.documentid, this.itemCode, this.itemName, this.itemEmail,
      this.itemScore, {required String title});

  String documentid;
  String itemCode;
  String itemName;
  String itemEmail;
  String itemScore;

  @override
  State<ShowScoreScreen2> createState() => _ShowScoreScreen2();
}

class _ShowScoreScreen2 extends State<ShowScoreScreen2> {
  // Define Controllet to set data
  // Define Object Service Data
  // ItemService itemService = ItemService();
  final ItemService itemService = ItemService();
  TextEditingController itemCode = TextEditingController();
  TextEditingController itemName = TextEditingController();
  TextEditingController itemEmail = TextEditingController();
  TextEditingController itemScore = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // Create Object Widget to get data
    itemCode.text = widget.itemCode;
    itemName.text = widget.itemName;
    itemEmail.text = widget.itemEmail;
    itemScore.text = widget.itemScore;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Show items"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: itemCode,
              decoration: InputDecoration(label: Text("Item ID-Code")),
            ),
            TextField(
              controller: itemName,
              decoration: InputDecoration(label: Text("Item Name")),
            ),
            TextField(
              controller: itemEmail,
              decoration: InputDecoration(label: Text("Item Email")),
            ),
            TextField(
              controller: itemScore,
              decoration: InputDecoration(label: Text("Item Score")),
            ),
            const SizedBox(
              height: 20,
            ),
           

            const SizedBox(
              height: 20,
            ),
           
          ],
        ),
      ),
    );
  }
}