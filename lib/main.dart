import 'package:flutter/material.dart';
import 'package:flutter_sqflite/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Sqflite Demo"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () async{
                int i = await DatabaseHelper.instance.insert({
                  'name': 'Mafe Garizábalo',
                });
                print("Primary key: " + i.toString());
              },
              child: Text('Insert'),
            ),
            FlatButton(
              onPressed: () async{
                List<Map<String, dynamic>> queryRows =
                    await DatabaseHelper.instance.queryAll();
                print(queryRows);
              },
              child: Text('Query'),
            ),
            FlatButton(
              onPressed: () async {
                int updatedId = await DatabaseHelper.instance.update({
                  '_id': 1,
                  'name': 'Mi mamá me mima',
                });
                print(updatedId);
              },
              child: Text('Update'),
            ),
            FlatButton(
              onPressed: () async{
                int deletedId = await DatabaseHelper.instance.delete(5);
                print(deletedId);
              },
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
