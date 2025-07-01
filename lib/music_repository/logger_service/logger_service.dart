import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class LogService {
  static final Logger _logger = Logger(printer: PrettyPrinter());
  static final Dio _dio = Dio(BaseOptions(baseUrl: ''));

  static Future<void> logToFile(String message) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/app_logs.txt');
      final time = DateTime.now().toIso8601String();
      final formattedMessage = '[$time] $message\n';
      await file.writeAsString(formattedMessage, mode: FileMode.append);
      await _dio.post('/log', data: {'message': formattedMessage});
    } catch (e) {
      debugPrint('Failed to write or send log: $e');
    }
  }

  static void log(String message) {
    _logger.i(message);
    logToFile(message);
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
    final errorMessage = 'ERROR: $message\n$error\n$stackTrace';
    logToFile(errorMessage);
  }
}
