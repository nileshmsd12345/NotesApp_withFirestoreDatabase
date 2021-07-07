import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'main.dart';

// ignore: must_be_immutable
class EditNote extends StatefulWidget {
  //DocumentSnapshot stores the data of this container like the global key
  late DocumentSnapshot? docToEdit;
  EditNote({this.docToEdit});

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  @override
  void initState() {
    // TODO: implement initState
    title = TextEditingController(text: widget.docToEdit!['title']);
    content = TextEditingController(text: widget.docToEdit!['content']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () {
              widget.docToEdit!.reference.update({
                'title': title.text,
                'content': content.text,
              }).whenComplete(() => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MyApp())));
            },
            child: Text('Save'),
          ),
          FlatButton(
            onPressed: () {
              widget.docToEdit!.reference.delete().whenComplete(() =>
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MyApp())));
            },
            child: Text('delete'),
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
