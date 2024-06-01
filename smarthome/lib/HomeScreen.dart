import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

_fetchdata() async {
  await Future.delayed(Duration(
      seconds: 1)); // simulira koliko je potrebno da se ceka recimo 1 sekunda
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int dropDownValue = 1;
  double score=0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    score = 100;
    return Scaffold(
      
      body: Container(
          color: getBackgroundColor(score),
          child: Column(
            children: [
              SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Text(
                        "Room:",
                        style: TextStyle(
                            overflow: TextOverflow.fade,
                            fontSize: 40.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                      DropdownButton<int>(
                        value: dropDownValue,
                        onChanged: (value) {
                          setState(() {
                            dropDownValue = value!;
                          });
                        },
                        style: TextStyle(
                            overflow: TextOverflow.fade,
                            fontSize: 39.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w800),
                        icon: const Icon(Icons.menu),
                        items: [
                          DropdownMenuItem<int>(
                            value: 1,
                            child: Text("Room one"),
                          ),
                          DropdownMenuItem<int>(
                            value:2,
                            child: Text("Room two"),
                          ),
                          DropdownMenuItem<int>(
                            value: 3,
                            child: Text("Room tree"),
                          ),
                          DropdownMenuItem<int>(
                            value: 4,
                            child: Text("Room four"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: FutureBuilder<dynamic>(
                    future: _fetchdata(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          margin: const EdgeInsets.all(100),
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: const Center(
                            child: SizedBox(
                              height: 50.0,
                              width: 50.0,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _fetchdata();
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(100),
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Column(
                              children: [
                                SizedBox(height: 30),
                                Text(
                                  "Overall score",
                                  style: TextStyle(
                                      overflow: TextOverflow.fade,
                                      fontSize: 19.0,
                                      color: getBackgroundColor(score),
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  score.toString(),
                                  style: TextStyle(
                                      overflow: TextOverflow.fade,
                                      fontSize: 70.0,
                                      color: getBackgroundColor(score),
                                      fontWeight: FontWeight.w800),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ],
          )),
    );
  }

  Color getBackgroundColor(double score) {
    final colors = [
      Color.fromARGB(212, 231, 62, 62), // Less saturated red
      Color.fromARGB(170, 255, 166, 0), // Less saturated orange
      Color(0xfff5f500), // Less saturated yellow
      Color(0xffd2ff92), // Less saturated greenish yellow
      Color.fromARGB(121, 0, 255, 34), // Less saturated green
    ];

    final ratios = [
      0.0,
      0.25,
      0.5,
      0.75,
      1.0
    ]; // Score thresholds for each color

    for (int i = 0; i < ratios.length - 1; i++) {
      final lowerRatio = ratios[i];
      final upperRatio = ratios[i + 1];
      if (score >= 100.0 * lowerRatio && score < 100.0 * upperRatio) {
        final ratioWithinRange =
            (score - 100.0 * lowerRatio) / (100.0 * (upperRatio - lowerRatio));
        return Color.lerp(colors[i], colors[i + 1], ratioWithinRange)!;
      }
    }

    // Default to green if score is 100 or above
    return colors.last;
  }
}
