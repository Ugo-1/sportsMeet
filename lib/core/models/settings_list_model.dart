import 'package:flutter/animation.dart';

class SettingsListModel {
  final String name;
  VoidCallback? onTap;

  SettingsListModel({
    required this.name,
    this.onTap,
  });
}
