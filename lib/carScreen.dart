// // ignore_for_file: sort_child_properties_last,, use_build_context_synchronously

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'dart:io';
import 'dart:typed_data';

class carScreen extends StatefulWidget {
  const carScreen({super.key});

  @override
  State<carScreen> createState() => _carScreenState();
}

class _carScreenState extends State<carScreen> {
  late Timer mytimer;
  late Timer mytimer2;
  // @override
  void initState() {
    timerfunction();
    super.initState();
  }

  void timerfunction() {
    mytimer2 = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      writeData("1", "S");
      //print("Stop");
    });
  }

  void writeData(String deviceID, String command) {
    Uint8List rawAddress = Uint8List.fromList([192, 168, 0, 102]);
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 0)
        .then((RawDatagramSocket socket) {
      // print('Sending from ${socket.address.address}:${socket.port}');
      int port = 8888;
      socket.send(
          command.codeUnits, InternetAddress.fromRawAddress(rawAddress), port);
    });
  }
  // Future writeData(String deviceID, String command) async {
  //   http.Response response = await http.post(
  //       Uri.parse("http://192.168.0.100:8000/writeData"),
  //       body: {"command": command, "deviceID": deviceID});

  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception("Error loading data");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Connect'),
                onPressed: () {
                  // writeData(dropdownvalue, myip.text);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const carScreen()),
                  // );
                },
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Joystick(
                  // stick: Container(
                  //   width: 50,
                  //   height: 50,
                  //   color:Color.fromARGB(31, 19, 1, 1),
                  // ),
                  mode: JoystickMode.horizontalAndVertical,
                  // period: Duration(),
                  onStickDragEnd: () {
                    timerfunction();
                  },
                  listener: (details) {
                    setState(() {
                      if (details.x > 0.3 && details.y == 0.0) {
                        //Up
                        //print("UP");
                        mytimer2.cancel();

                        writeData("1", "F");
                      }
                      if (details.x < -0.3 && details.y == 0.0) {
                        //Down
                        //print("down");
                        mytimer2.cancel();

                        writeData("1", "B");
                      }
                      if (details.x == 0.0 && details.y < 0.3) {
                        //Left
                        //print("Left");
                        mytimer2.cancel();

                        writeData("1", "L");
                      }
                      if (details.x == 0.0 && details.y > 0.3) {
                        //Right
                        //print("Right");
                        mytimer2.cancel();

                        writeData("1", "R");
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
