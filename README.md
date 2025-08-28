# Date Picker Lunar Calendar

This plugin allows to pick date with lunar calendar, solar calendar and can convert from solar date to lunar date.


## How to Use

**Pick DateTime:**

```dart
import 'package:base_image/base_image.dart';

DateTime? dateResponse = await DatePickerLunarCalendar().selectDate(context,initDate: dateSelected,endDate: DateTime.now(),beginDate: DateTime(2024,12,01));
```

**Convert solar date to lunar date:**


```dart
import 'package:base_image/base_image.dart';


DatePickerLunarCalendar().convertSolarToLunar(dateSelected!)
```
