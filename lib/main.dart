import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Date and Time Picker',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedDate = '';
  String _selectedTime = '';


  // Function to print current date and time
  void _printCurrentDateTime() {
    DateTime now = DateTime.now();
    String combinedDateTime = _selectedDate + "T" + _selectedTime;
    DateTime futureDateTime = DateTime.parse(combinedDateTime);
    DateTime currentDateTime = DateTime.now();
    Duration durationUntilReminder = futureDateTime.difference(currentDateTime);
    
    Timer(durationUntilReminder, () {
      print('yay');
      final player = AudioPlayer();
      player.play(UrlSource('https://www2.cs.uic.edu/~i101/SoundFiles/CantinaBand60.wav'));
    });
  }

  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050), // Limit to the year   2050
    );
    if (picked != null) {
      setState(() {
        _selectedDate = "${picked.toLocal()}".split(' ')[0]; // Format date
      });
      print(_selectedDate);
    }
  }

  Future<void> _showTimePicker() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = "${picked.hour}:${picked.minute <  10 ? '0' : ''}${picked.minute}"; // Format time
      });
      print(_selectedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date and Time Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _selectedDate != null ? _selectedDate! : 'No date selected!',
              style: const TextStyle(fontSize:   20),
            ),
            const SizedBox(height:   20),
            Text(
              _selectedTime != null ? _selectedTime! : 'No time selected!',
              style: const TextStyle(fontSize:   20),
            ),
            const SizedBox(height:   20),
            ElevatedButton(
              onPressed: _showDatePicker,
              child: const Text('Select Date'),
            ),
            const SizedBox(height:   10),
            ElevatedButton(
              onPressed: _showTimePicker,
              child: const Text('Select Time'),
            ),
            const SizedBox(height:   10),
            ElevatedButton(
              onPressed: _printCurrentDateTime,
              child: const Text('Print Current Date and Time'),
            ),
          ],
        ),
      ),
    );
  }
}

