 class HomeData{
   final List<String> message;
   final double score;

   HomeData({
      this.score=0,
      this.message = const []
   });
   double get Score => score;
factory HomeData.fromJson(Map<String, dynamic> json) {
    final List<String> messages = List<String>.from(json['messages'] ?? []);
    final double score = (json['score'] ?? 0).toDouble(); // Convert to double
  print(score);
    return HomeData(score: score, message: messages);
  }
   



}