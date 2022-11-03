// ignore_for_file: sort_child_properties_last,, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("MY RC Car App")),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Future writeData(String deviceID, String command) async {
    http.Response response = await http.post(
        Uri.parse("http://192.168.0.100:8000/writeData"),
        body: {"command": command, "deviceID": deviceID});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error loading data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
            height: 50,
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              child: const Text('F'),
              onPressed: () {
                //  login();
                writeData("1", "F");
              },
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              child: const Text('B'),
              onPressed: () {
                //  login();
                writeData("1", "B");
              },
            ),
          ),
        ],
      ),
    );
  }
}
