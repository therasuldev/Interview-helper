import 'dart:developer';

class ExceptionModel {
  final String description;
  
  ExceptionModel({required this.description}) {
    log(description);
  }
}
