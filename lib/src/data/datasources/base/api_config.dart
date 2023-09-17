import 'package:flutter/foundation.dart';

@immutable
class ApiConfig {
  final String _api = 'https://api.emailjs.com/api/v1.0/email/send';

  final Map<String, String> _headers = {
    'origin': 'https://api.emailjs.com',
    'Content-Type': 'application/json',
  };

  Uri get api => Uri.parse(_api);
  Map<String, String> get headers => _headers;
}
