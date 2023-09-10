import 'package:flutter/foundation.dart';

@immutable
class ApiConfig {
  final String _domain = 'https://api.emailjs.com/';
  final String _send = 'api/v1.0/email/send';

  final Map<String, String> _headers = {
    'origin': 'http://localhost',
    'Content-Type': 'application/json',
  };

  Uri get url => Uri.parse('$_domain$_send');
  Map<String, String> get headers => _headers;
}
