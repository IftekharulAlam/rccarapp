// // ignore_for_file: sort_child_properties_last,, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';

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
    mytimer2 = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      writeData("1", "S");
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        mytimer2.cancel();
                        writeData("1", "B");
                        timerfunction();
                      },
                      onLongPressStart: (detail) {
                        mytimer2.cancel();
                        setState(() {
                          mytimer = Timer.periodic(const Duration(), (t) {
                            writeData("1", "B");
                          });
                        });
                      },
                      onLongPressEnd: (detail) {
                        mytimer.cancel();
                        timerfunction();
                      },
                      child: Container(
                        height: 250,
                        //width: 180,
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 100,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        mytimer2.cancel();
                        writeData("1", "F");
                        timerfunction();
                      },
                      onLongPressStart: (detail) {
                        mytimer2.cancel();
                        setState(() {
                          mytimer = Timer.periodic(const Duration(), (t) {
                            writeData("1", "F");
                          });
                        });
                      },
                      onLongPressEnd: (detail) {
                        mytimer.cancel();
                        timerfunction();
                      },
                      child: Container(
                        height: 250,
                        //width: 180,
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.arrow_forward,
                          size: 100,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    mytimer2.cancel();
                    writeData("1", "L");
                    timerfunction();
                  },
                  onLongPressStart: (detail) {
                    mytimer2.cancel();
                    setState(() {
                      mytimer = Timer.periodic(const Duration(), (t) {
                        writeData("1", "L");
                      });
                    });
                  },
                  onLongPressEnd: (detail) {
                    mytimer.cancel();
                    timerfunction();
                  },
                  child: Container(
                    height: 250,
                    //width: 180,
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      Icons.arrow_upward,
                      size: 100,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    mytimer2.cancel();
                    writeData("1", "R");
                    timerfunction();
                  },
                  onLongPressStart: (detail) {
                    mytimer2.cancel();
                    setState(() {
                      mytimer = Timer.periodic(const Duration(), (t) {
                        writeData("1", "R");
                      });
                    });
                  },
                  onLongPressEnd: (detail) {
                    mytimer.cancel();
                    timerfunction();
                  },
                  child: Container(
                    height: 250,
                    //width: 180,
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      Icons.arrow_downward,
                      size: 100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
