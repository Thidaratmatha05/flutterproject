import 'dart:js';

import 'package:flutterproject/services/item_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewItemScreen extends StatelessWidget {
  // Create object
  final _itemName = TextEditingController();
  final _itemCode = TextEditingController();
  final _itemEmil = TextEditingController();
  final _itemScore = TextEditingController();

  final ItemService _itemService = ItemService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _itemCode,
              decoration: InputDecoration(label: Text("Item ID-Code")),
            ),
            TextField(
              controller: _itemName,
              decoration: InputDecoration(label: const Text("Item Name")),
            ),
            TextField(
              controller: _itemEmil,
              decoration: InputDecoration(label: Text("Item Email")),
            ),
            TextField(
              controller: _itemScore,
              decoration: InputDecoration(label: Text("Item Score")),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  _addItem(context);
                },style:
                  ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 0, 92, 252)),
              child: const Text("Save"),)
          ],
        ),
      ),
    );
  }

  _addItem(BuildContext context) {
     if(_itemCode.text == "" || _itemScore.text == "" || _itemName.text == ""){
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error")));
     }else{
    _itemService.addItem2Firebase(_itemName.text, {
      "itemCode": _itemCode.text,
      "itemName": _itemName.text,
      "itemEmail": _itemEmil.text,
      "itemScore": _itemScore.text
    });
    Navigator.pop(context);
  }
 }
}
