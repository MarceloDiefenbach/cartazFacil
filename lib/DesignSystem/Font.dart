import 'package:flutter/material.dart';
import 'package:cartazrapido/DesignSystem/DesingSystem.dart';

class AppFonts {
  /// Large Title (34pt)
  static TextStyle largeTitle({
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        fontSize: 34,
        fontWeight: weight,
        color: color ?? AppColors.text,
        letterSpacing: 0.0,
        height: 1.2,
      );

  /// Title 1 (28pt)
  static TextStyle title1({
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        fontSize: 28,
        fontWeight: weight,
        color: color ?? AppColors.text,
        height: 1.2,
      );

  /// Title 2 (22pt)
  static TextStyle title2({
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        fontSize: 22,
        fontWeight: weight,
        color: color ?? AppColors.text,
        height: 1.2,
      );

  /// Title 3 (20pt)
  static TextStyle title3({
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        fontSize: 20,
        fontWeight: weight,
        color: color ?? AppColors.text,
        height: 1.2,
      );

  /// Headline (17pt, semibold)
  static TextStyle headline({
    Color? color,
    FontWeight weight = FontWeight.w600,
  }) =>
      TextStyle(
        fontSize: 17,
        fontWeight: weight,
        color: color ?? AppColors.text,
        height: 1.25,
      );

  /// Body (17pt)
  static TextStyle body({
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        fontSize: 17,
        fontWeight: weight,
        color: color ?? AppColors.text,
        height: 1.4,
      );

  /// Callout (16pt)
  static TextStyle callout({
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        fontSize: 16,
        fontWeight: weight,
        color: color ?? AppColors.text,
        height: 1.3,
      );

  /// Subhead (15pt)
  static TextStyle subhead({
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        fontSize: 15,
        fontWeight: weight,
        color: color ?? AppColors.text,
        height: 1.3,
      );

  /// Footnote (13pt)
  static TextStyle footnote({
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        fontSize: 13,
        fontWeight: weight,
        color: color ?? AppColors.text,
        height: 1.2,
      );

  /// Caption 1 (12pt)
  static TextStyle caption1({
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        fontSize: 12,
        fontWeight: weight,
        color: color ?? AppColors.text,
        height: 1.2,
      );

  /// Caption 2 (11pt)
  static TextStyle caption2({
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        fontSize: 11,
        fontWeight: weight,
        color: color ?? AppColors.text,
        height: 1.2,
      );
}