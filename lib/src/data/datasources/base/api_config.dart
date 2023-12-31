import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

@immutable
class ApiConfig {
  final Map<String, String> _headers = {
    'origin': 'https://api.emailjs.com',
    'Content-Type': 'application/json',
  };

  Uri get api => Uri.parse(dotenv.env['SEND_EMAIL_API']!);
  Map<String, String> get headers => _headers;
}
