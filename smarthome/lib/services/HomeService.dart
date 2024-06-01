import 'dart:convert';

import 'package:smarthome/models/HomeData.dart';
import 'package:http/http.dart' as http;

class HomeService{
  static const URL="";
  final String apiKey;

  HomeService(this.apiKey);

  Future<HomeData> getHomeData(String roomName) async{

    final response = await http.get(Uri.parse(URL));
    String message = "";
    String room= "";
  
    if(response.statusCode ==200){
      return HomeData.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Failed to load weather");
    }




  }

}