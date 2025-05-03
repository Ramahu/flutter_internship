import 'package:flutter/material.dart';

import '../../../core/themes/app_colors.dart';

Widget defaultGradientButton({
  required double width,
  required double height,
  required Color color1,
  required Color color2,
  required String text,
  required VoidCallback function,
  double radius = 35.0,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        backgroundColor: AppColors.transparent,
        shadowColor: AppColors.transparent,
        padding: EdgeInsets.zero,
      ).copyWith(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          return null;
        }),
      ),
      onPressed: function,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(color: AppColors.white, fontSize: 23),
          ),
        ),
      ),
    ),
  );
}
