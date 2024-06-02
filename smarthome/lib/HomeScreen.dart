import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smarthome/models/HomeData.dart';
import 'package:smarthome/services/HomeService.dart';

HomeService homeService = HomeService();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int dropDownValue = 0;
  double score = 0;
  List<String> roomNames = [];
  int index = 0;
  HomeData homeData = HomeData();

  @override
  void initState() {
    super.initState();
    homeService.getHomeData(dropDownValue);
    score = homeData.score;
    print(score);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: homeService.getHomeData(dropDownValue),
        builder: (context, snapshot) {
        if(!snapshot.hasData){


          return Container(

          color: getBackgroundColor(0),
          );
          
          


        } else{
          return Container(
            color: getBackgroundColor(snapshot.data!.score),
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
                        FutureBuilder(
                          future: homeService.getHomeName(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            } else {
                              if (roomNames.isEmpty) {
                                roomNames = snapshot.data!;
                              }
                              return DropdownButton<int>(
                                  value: dropDownValue,
                                  onChanged: (value) {
                                    setState(() {
                                      
                                      dropDownValue = value!;
                                      homeService.getHomeData(dropDownValue);
                                      print(homeData.score);
                                      
                                      
                                    });
                                  },
                                  style: TextStyle(
                                      overflow: TextOverflow.fade,
                                      fontSize: 39.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w800),
                                  icon: const Icon(Icons.menu),
                                  items: generateDropdownItems(roomNames));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                            onTap: () {
                              setState(() {
                                homeService.getHomeData(dropDownValue);
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
                                        color: getBackgroundColor(
                                           snapshot.data!.score),
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    snapshot.data!.score.toString(),
                                    style: TextStyle(
                                        overflow: TextOverflow.fade,
                                        fontSize: 70.0,
                                        color: getBackgroundColor(
                                            snapshot.data!.score),
                                        fontWeight: FontWeight.w800),
                                  )
                                ],
                              ),
                            ),
                          )
                

                ),
                Text(
                  snapshot.data!.message[0],
                  style: TextStyle(
                                        overflow: TextOverflow.fade,
                                        fontSize: 35.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                ),
                





              ],
            ));



        } 
        }
        
      ),
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
    return colors.last;
  }

  List<DropdownMenuItem<int>> generateDropdownItems(List<String> roomNames) {
    index = 0;
    return roomNames.map((roomName) {
      return DropdownMenuItem<int>(
        value: index++,
        child: Text(roomName),
      );
    }).toList();
  }
}
