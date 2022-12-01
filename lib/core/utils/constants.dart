import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sports_meet/core/utils/color_palette.dart';
import 'package:sports_meet/core/utils/size_manager.dart';

InputDecorationTheme kFormTextDecoration = InputDecorationTheme(
  hintStyle: const TextStyle(
    color: Palette.inactiveTextField,
  ),
  labelStyle: const TextStyle(
    color: Palette.mainBlack,
  ),
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      10,
    ),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      10,
    ),
    borderSide: BorderSide.none,
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      10,
    ),
    borderSide: const BorderSide(
      width: 1,
      color: Colors.red,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      10,
    ),
    borderSide: const BorderSide(
      width: 1,
      color: Colors.red,
    ),
  ),
);

InputDecoration kIntlPhoneDecoration = InputDecoration(
  labelText: 'Search Country',
  labelStyle: const TextStyle(
    color: Palette.secondaryBlack,
  ),
  suffixIcon: const Icon(
    Icons.search_rounded,
    color: Palette.secondaryBlack,
  ),
  border: UnderlineInputBorder(
    borderSide: BorderSide(
      width: SizeMg.width(1),
      color: Palette.mainBlack,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      width: SizeMg.width(1),
      color: Palette.mainBlack,
    ),
  ),
);

PinTheme kPinInputTheme = PinTheme(
  width: SizeMg.width(56),
  height: SizeMg.height(60),
  textStyle: TextStyle(
    fontSize: SizeMg.text(22),
    color: Palette.secondaryBlack,
  ),
  decoration: BoxDecoration(
    color: Palette.inactiveGray,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.transparent),
  ),
);