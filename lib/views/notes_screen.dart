// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_database/box/boxes_class.dart';
import 'package:hive_database/model/notes_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive Database"),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (BuildContext context, box, Widget? child) {
          final data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
            itemCount: box.length,
              itemBuilder: (context,index){
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data[index].title),
                      Text(data[index].description),
                    ],
                  ),
                ),
              );
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showDialog();
        },
        child: Text("Add"),
      ),
    );
  }

  Future _showDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Notes"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cencel"),
            ),
            TextButton(
              onPressed: () {
                final data = NotesModel(
                  title: titleController.text,
                  description: descriptionController.text,
                );
                final box = Boxes.getData();
                box.add(data);
                data.save();
                titleController.clear();
                descriptionController.clear();
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "title",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: "description",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
