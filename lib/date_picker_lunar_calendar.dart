import 'package:flutter/material.dart';
import 'package:lunar_calendar_converter_new/lunar_solar_converter.dart';

import 'date_picker_lunar_calendar.dart';
export 'src/src.dart';

/// Hàm khởi tạo
class DatePickerLunarCalendar {
  /// Hàm để chọn ngày từ lịch dương, có ngày âm bên dưới
  Future<DateTime?> selectDate(BuildContext context,
      {DateTime? initDate, DateTime? beginDate, DateTime? endDate}) async {
    DateTime? result = await showDialog(
        context: context,
        builder: (contextPopup) => AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  return DatePickerLunarCalendarWidget(
                    dateSelected: initDate ?? DateTime.now(),
                    contextPopup: contextPopup,
                    endDate: endDate,
                    beginDate: beginDate,
                  );
                },
              ),
            ));
    return result;
  }

  /// Hàm chuyển đổi ngày dương sang ngày âm
  DateTime convertSolarToLunar(DateTime solarDate) {
    Solar solar = Solar(
        solarYear: solarDate.year,
        solarMonth: solarDate.month,
        solarDay: solarDate.day);
    Lunar lunar = LunarSolarConverter.solarToLunar(solar);
    return DateTime(
        lunar.lunarYear ?? 1900, lunar.lunarMonth ?? 1, lunar.lunarDay ?? 1);
  }

  /// Hàm chuyển đổi ngày âm sang ngày dương
  DateTime convertLunarToSolar(Lunar lunarDate) {
    Solar solar = LunarSolarConverter.lunarToSolar(lunarDate);
    return DateTime(
        solar.solarYear ?? 1900, solar.solarMonth ?? 1, solar.solarDay ?? 1);
  }
}
