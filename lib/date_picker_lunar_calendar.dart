
import 'package:flutter/material.dart';
import 'package:lunar_calendar_converter_new/lunar_solar_converter.dart';

import 'date_picker_lunar_calendar.dart';
import 'date_picker_lunar_calendar_platform_interface.dart';
export 'src/src.dart';


class DatePickerLunarCalendar {
  Future<DateTime?> selectDate(BuildContext context, {DateTime? initDate,DateTime? beginDate,DateTime? endDate }) async {
    DateTime? result = await showDialog(
        context: context,
        builder: (contextPopup) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(
                  Radius.circular(10.0))),
          content: Builder(
            builder: (context) {
              return DatePickerLunarCalendarWidget(dateSelected: initDate??DateTime.now(), contextPopup: contextPopup,endDate: endDate,beginDate: beginDate,);
            },
          ),
        )
    );
    return result;
  }

  DateTime convertSolarToLunar(DateTime solarDate){
    Solar solar = Solar(solarYear: solarDate.year, solarMonth: solarDate.month, solarDay: solarDate.day);
    Lunar lunar = LunarSolarConverter.solarToLunar(solar);
    return DateTime(lunar.lunarYear??1900,lunar.lunarMonth??1,lunar.lunarDay??1);
  }
}
