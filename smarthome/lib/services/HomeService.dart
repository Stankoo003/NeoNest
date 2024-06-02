import 'dart:convert';

import 'package:smarthome/models/HomeData.dart';
import 'package:http/http.dart' as http;
import 'package:smarthome/Constants.dart';

class HomeService{


  HomeService();

  Future<List<String>> getHomeName() async{

  final response = await http.get(Uri.parse(url+"/rooms"));
   if(response.statusCode ==200){
      return List<String>.from(jsonDecode(response.body)['rooms']);
   }else{
   
   throw Exception(
            "Error fetching data: Status code ${response.statusCode}");
      }

  }
  Future<List<String>> getMessageData(int value) async{
    final response = await http.get(Uri.parse(url+"/room/"+value.toString()));
     if(response.statusCode ==200){
      return List<String>.from(jsonDecode(response.body)['messages']);
   }else{
   
   throw Exception(
            "Error fetching data: Status code ${response.statusCode}");
      }


  }



  Future<HomeData> getHomeData(int value) async{

    final response = await http.get(Uri.parse(url+"/room/"+value.toString()));
    
    if(response.statusCode ==200){
      
      return HomeData.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Failed to load home data");
    }




  }

}