import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:smarthome/Constants.dart';
import 'package:smarthome/api_keys.dart';


class DesktopView extends StatefulWidget {
  const DesktopView({super.key});

  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  final CalendarService _calendarService = CalendarService();

  List<dynamic> _events = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    final events = await _calendarService.getEvents();
    setState(() {
      _events = events;
    });
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Google Calendar Events'),
        ),
        body: _events.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  final event = _events[_events.length-1];
                  return ListTile(
                    title: Text(event['summary'] ?? 'No Title'),
                    subtitle: Text(event['start']['dateTime'] ?? 'No Date'),
                  );
                },
              ),
      );
  }
}

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

  Future<dynamic> getLastEvent() async {
    final response = await http.get(
      Uri.parse('https://www.googleapis.com/calendar/v3/calendars/${user.email}/events?key=${google_calendar_api}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['items'] as List<dynamic>).last;
    } else {
      throw Exception('Failed to load events');
    }
  }
  
}
