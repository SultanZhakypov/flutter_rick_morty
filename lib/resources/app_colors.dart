import 'package:flutter/material.dart';

abstract class AppColors {
  static const backgroudColor = Color(0xff0B1E2D);
  static const textfieldColor = Color(0xff152A3A);
  static const hintColor = Color(0xff5B6975);
  static const selectedColorNavBar = Color(0xff43D049);
  static const unselectedColorNavBar = Color(0xff5B6975);

  static const speciesAndGenderStyle = TextStyle(
    color: AppColors.hintColor,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );
  static const nameStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
  static const statusStyle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
  );
  static const detailscreenTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    letterSpacing: 0.25,
    fontWeight: FontWeight.w400,
  );
  static const errorstateText = TextStyle(
    color: AppColors.hintColor,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
  );
  static const textApperanceOverline = TextStyle(
    color: Color(0xff5b6975),
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
  );
  static const textApperanceSubtitle = TextStyle(
    color: Color(0xffffffff),
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  );
}
