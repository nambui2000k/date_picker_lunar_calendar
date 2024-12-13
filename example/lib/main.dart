import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:date_picker_lunar_calendar/date_picker_lunar_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? dateSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin Date Picker Lunar Calendar'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: double.infinity),
          Text("Ngày dương: ${dateSelected}"),
          Text(
              "Ngày âm: ${dateSelected == null ? "---" : DatePickerLunarCalendar().convertSolarToLunar(dateSelected!)}"),
          TextButton(
            onPressed: () async {
              DateTime? dateResponse = await DatePickerLunarCalendar()
                  .selectDate(context,
                      initDate: dateSelected,
                      colorTheme: Colors.red,
                      endDate: DateTime.now(),
                      beginDate: DateTime(2024, 12, 01));
              if (dateResponse != null) {
                dateSelected = dateResponse;
                setState(() {});
              }
            },
            child: Text("Chọn ngày"),
          ),
        ],
      ),
    );
  }
}
