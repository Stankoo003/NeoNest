 class HomeData{
   final String message;
   final String currentRoom;

   HomeData({
     required this.currentRoom,
     required this.message
   });

   factory HomeData.fromJson(Map<String, dynamic> json){
    return HomeData(currentRoom: json['stewki'], message: json['weather']);


   }



}