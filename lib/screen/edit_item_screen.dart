// ignore_for_file: unnecessary_new

import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/services/item_service.dart';

class EditItemScreen extends StatefulWidget {
  // Definde Object to get data
  EditItemScreen(this.documentid, this.itemCode, this.itemName, this.itemEmail,
      this.itemScore);

  String documentid;
  String itemCode;
  String itemName;
  String itemEmail;
  String itemScore;

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
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
        title: const Text("Edit Item"),
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
            ElevatedButton(onPressed: () {_editItem(context);},
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 0, 17, 255)),
              child: const Text("Edit"),
            ),

            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {_deleteItem(context);},
                // Define Button Colors!
                style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 255, 18, 1)),
                child: const Text("Delete")),
          ],
        ),
      ),
    );
  }

  // Make a function edit & delete data on firebase
  void _editItem(BuildContext context) {
    if(itemCode.text == "" || itemName.text == "" || itemScore.text == ""){
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error")));
     }else{
      itemService
  .editItem(context, {"itemCode": itemCode.text,"itemName": itemName.text},
   widget.documentid)
          .then((value) => Navigator.pop(context));
      itemCode.text = "";
      itemName.text = "";
      itemEmail.text = "";
      itemScore.text = "";

     }   
  }

  void _deleteItem(BuildContext context) { 
      itemService
          .deleteItem(context, widget.documentid)
          .then((value) => Navigator.pop(context));
      itemCode.text = "";
      itemName.text = "";
      itemEmail.text = "";
      itemScore.text = "";
    
  }
}
