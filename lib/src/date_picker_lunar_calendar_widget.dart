import 'package:date_picker_lunar_calendar/src/button_widget.dart';
import 'package:date_picker_lunar_calendar/src/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunar_calendar_converter_new/lunar_solar_converter.dart';

/// Widget hiển thị lịch dương + lịch âm
class DatePickerLunarCalendarWidget extends StatefulWidget {
  final DateTime dateSelected;

  /// Ngày được chọn
  final BuildContext contextPopup;
  final DateTime? endDate;

  /// Ngày kết thúc
  final DateTime? beginDate;
  final Color? colorTheme;

  /// Ngày bắt đầu
  const DatePickerLunarCalendarWidget(
      {Key? key,
      required this.dateSelected,
      required this.contextPopup,
      this.endDate,
      this.beginDate,
      this.colorTheme});

  @override
  State<DatePickerLunarCalendarWidget> createState() =>
      _DatePickerLunarCalendarWidgetState();
}

class _DatePickerLunarCalendarWidgetState
    extends State<DatePickerLunarCalendarWidget> {
  late DateTime dateSelected;
  late DateTime? endDate;
  late List<DateTime?> days;
  late int month;
  late int year;
  late DateTime? beginDate;
  late Color? colorTheme;

  @override
  void initState() {
    dateSelected = DateTime(widget.dateSelected.year, widget.dateSelected.month,
        widget.dateSelected.day);
    month = dateSelected.month;
    year = dateSelected.year;
    endDate = widget.endDate;
    beginDate = widget.beginDate;
    colorTheme = widget.colorTheme ?? Colors.blue;

    getDays();
    super.initState();
  }

  void getDays() {
    days = getDaysInMonth(year, month);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              InkWell(
                  onTap: () {
                    year = year - 1;
                    getDays();
                    setState(() {});
                  },
                  child: Icon(
                    CupertinoIcons.chevron_left_2,
                    size: 18,
                  )),
              InkWell(
                onTap: () {
                  if (month - 1 <= 0) {
                    month = 12;
                    year = year - 1;
                  } else {
                    month = month - 1;
                  }
                  getDays();
                  setState(() {});
                },
                child: Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(11),
                  child: Icon(
                    CupertinoIcons.chevron_left,
                    size: 18,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Tháng " +
                        DateFormat('MM yyyy').format(DateTime(year, month, 1)),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colorTheme),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  if (month + 1 > 12) {
                    month = 1;
                    year = year + 1;
                  } else {
                    month = month + 1;
                  }
                  getDays();
                  setState(() {});
                },
                child: Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(11),
                  child: Icon(
                    CupertinoIcons.chevron_right,
                    size: 18,
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    year = year + 1;
                    getDays();
                    setState(() {});
                  },
                  child: Icon(
                    CupertinoIcons.chevron_right_2,
                    size: 18,
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 1,
            height: 1,
            color: clrF3F4F6,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Wrap(
                  children: [
                    DateTime.monday,
                    DateTime.tuesday,
                    DateTime.wednesday,
                    DateTime.thursday,
                    DateTime.friday,
                    DateTime.saturday,
                    DateTime.sunday
                  ]
                      .map<Widget>((dow) => Container(
                            width: (width - 130) / 7,
                            child: Center(
                                child: Text(
                              getDisplayDayOfWeek(dow),
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            )),
                          ))
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Wrap(
                  runAlignment: WrapAlignment.spaceBetween,
                  children: days
                      .map<Widget>((day) => Builder(builder: (context) {
                            if (day == null) {
                              return Container(
                                width: (width - 130) / 7,
                              );
                            }
                            bool isAfterFuture = false;
                            if (endDate != null) {
                              if (day.isAfter(endDate!)) {
                                isAfterFuture = true;
                              }
                            }
                            bool isBeforeFuture = false;
                            if (beginDate != null) {
                              if (day.isBefore((beginDate)!)) {
                                isBeforeFuture = true;
                              }
                            }
                            return InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {
                                if (isAfterFuture || isBeforeFuture) {
                                  return;
                                }
                                dateSelected = day;

                                setState(() {});
                              },
                              child: Container(
                                width: (width - 130) / 7,
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: !dateSelected.isAtSameMomentAs(day)
                                          ? Colors.white
                                          : colorTheme),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat("d").format(day),
                                          style: TextStyle(
                                              fontSize: 16,
                                              // fontWeight: FontWeight.w600,
                                              color: dateSelected
                                                      .isAtSameMomentAs(day)
                                                  ? Colors.white
                                                  : ((isAfterFuture ||
                                                          isBeforeFuture)
                                                      ? Colors.grey
                                                      : Colors.black)),
                                        ),
                                        Builder(builder: (context) {
                                          Lunar lunarDay =
                                              LunarSolarConverter.solarToLunar(
                                                  Solar(
                                                      solarYear: day.year,
                                                      solarMonth: day.month,
                                                      solarDay: day.day));
                                          return Text(
                                            "${lunarDay.lunarDay}/${lunarDay.lunarMonth}",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: dateSelected
                                                        .isAtSameMomentAs(day)
                                                    ? Colors.white
                                                    : ((isAfterFuture ||
                                                            isBeforeFuture)
                                                        ? Colors.grey
                                                        : Colors.grey)),
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }))
                      .toList(),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            height: 1,
            color: clrF3F4F6,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ButtonCustom(
                  title: DateFormat("dd/MM/yyyy").format(dateSelected),
                  onClick: () {
                    // Navigator.pop(contextPopup);
                  },
                  height: 37,
                  padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
                  bgColor: Colors.white,
                  borderColor: colorTheme,
                  textColor: colorTheme,
                ),
              ),
              SizedBox(
                width: 32,
              ),
              Expanded(
                child: ButtonCustom(
                  title: "Đồng ý",
                  onClick: () {
                    /// Submit sẽ trả về ngày được chọn
                    Navigator.pop(widget.contextPopup, dateSelected);
                  },
                  height: 37,
                  padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
                  bgColor: colorTheme,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// Hiển thị thứ
  String getDisplayDayOfWeek(int dow) {
    if (dow == DateTime.monday) {
      return "T2";
    }
    if (dow == DateTime.tuesday) {
      return "T3";
    }
    if (dow == DateTime.wednesday) {
      return "T4";
    }
    if (dow == DateTime.thursday) {
      return "T5";
    }
    if (dow == DateTime.friday) {
      return "T6";
    }
    if (dow == DateTime.saturday) {
      return "T7";
    }
    if (dow == DateTime.sunday) {
      return "CN";
    }
    return "";
  }

  /// Lấy danh sách ngày trong tháng
  List<DateTime?> getDaysInMonth(int year, int month) {
    /// Tạo một danh sách để chứa các ngày
    List<DateTime?> daysInMonth = [];

    // /Lấy số ngày trong tháng hiện tại
    int daysInMonthCount = DateTime(year, month + 1, 0).day;

    /// Thêm từng ngày vào danh sách
    for (int day = 1; day <= daysInMonthCount; day++) {
      daysInMonth.add(DateTime(year, month, day));
    }

    int indexFirstDay = daysInMonth[0]!.weekday;
    for (int i = 0; i < indexFirstDay - 1; i++) {
      daysInMonth.insert(0, null);
    }
    return daysInMonth;
  }
}
