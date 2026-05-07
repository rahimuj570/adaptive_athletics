import 'package:flutter/material.dart';

class Notifications {
  final String title;
  final String message;
  final IconData icon;

  Notifications({
    required this.title,
    required this.message,
    this.icon = Icons.notifications,
  });
}
