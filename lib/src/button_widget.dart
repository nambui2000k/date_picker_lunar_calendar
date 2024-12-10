import 'package:date_picker_lunar_calendar/src/style.dart';
import 'package:flutter/material.dart';

import 'date_picker_lunar_calendar_widget.dart';

class ButtonCustom extends StatelessWidget {
  final String title;
  final Function onClick;
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final WidgetStateProperty<EdgeInsetsGeometry?>? padding;

  const ButtonCustom({super.key, required this.title, required this.onClick, this.bgColor, this.textColor, this.borderColor, this.height, this.width, this.padding});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          onClick();
        },
        style: ButtonStyle(
            textStyle: WidgetStateProperty.all<TextStyle>(
                const TextStyle(fontSize: 16,)),
            padding: padding??WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 8, vertical: 16)),
            foregroundColor: WidgetStateProperty.all<Color>(textColor??Colors.white),
            backgroundColor: WidgetStateProperty.all<Color>(bgColor??clrFAD209),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  side:BorderSide(color: borderColor??Colors.transparent),
                  borderRadius: BorderRadius.circular(16),
                ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
            ),),
          ],
        ),
      ),
    );
  }
}
