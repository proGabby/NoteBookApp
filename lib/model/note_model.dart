import 'package:flutter/material.dart';

class Notes {
  final String id;
  final String title;
  final String msg;
  final DateTime date;
  Notes(
      {required this.id,
      required this.title,
      required this.msg,
      required this.date});
}
