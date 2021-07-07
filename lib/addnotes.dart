import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/main.dart';

// ignore: must_be_immutable
class AddNote extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () {
              ref.add({
                'title': title.text,
                'content': content.text,
              }).whenComplete(() => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MyApp())));
            },
            child: Text('Save'),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(
                    hintText: 'Title',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: content,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      hintText: 'Content',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
