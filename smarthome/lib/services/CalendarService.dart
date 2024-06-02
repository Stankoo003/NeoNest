import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smarthome/Constants.dart';
import 'package:smarthome/api_keys.dart';

class CalendarService {

  Future<List<dynamic>> getEvents() async {
    final response = await http.get(
      Uri.parse('https://www.googleapis.com/calendar/v3/calendars/${user.email}/events?key=${google_calendar_api}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['items'] as List<dynamic>;
    } else {
      throw Exception('Failed to load events');
    }
  }
}
