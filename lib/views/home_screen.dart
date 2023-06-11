// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive Database"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: Hive.openBox("info"),
              builder: (context,snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }else{
              return Text(snapshot.data!.get("listData")[1]['name']);
            }
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox("info");
          box.put("name", "Sohag");
          box.put("address", "Dhaka");
          box.put("listData", [
            {
              'name': "Raiyan",
              'age': 4,
            },
            {
              'name': "Sharif",
              'age': 24,
            }
          ]);
          print("=====print data=====");
          print(box.get("name"));
          print(box.get("address"));
          print(box.get("listData")[1]['name']);
        },
        child: Text("Add"),
      ),
    );
  }
}
