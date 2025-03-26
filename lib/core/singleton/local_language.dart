import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class LocalizationService {
  static final LocalizationService _instance = LocalizationService._internal();

  factory LocalizationService() => _instance;

  LocalizationService._internal();

  late LocalizationDelegate delegate;

  void init(BuildContext context) {
    delegate = LocalizedApp.of(context).delegate;
  }
}