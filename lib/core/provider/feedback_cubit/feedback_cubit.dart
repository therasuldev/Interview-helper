import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:interview_prep/core/model/email/emailjs.dart';
import 'package:interview_prep/core/model/error/error_model.dart';

import 'package:http/http.dart' as http;

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  final Uri apiUrl;
  final Map<String, String> headers;
  FeedbackCubit({required this.apiUrl, required this.headers})
      : super(FeedbackState.unknown);

  void send({required MSGParams params}) async {
    final emailJS = EmailJS(msgParams: params);

    try {
      emit(state.copyWith(loading: true));

      final response = await http.post(
        apiUrl,
        headers: headers,
        body: json.encode(emailJS.toJson()),
      );
      if (response.statusCode == 200) {
        emit(state.copyWith(
          loading: false,
          event: FeedbackEvents.success,
        ));
        return;
      }
      emit(state.copyWith(
        loading: false,
        event: FeedbackEvents.fail,
        exception: ExceptionModel(description: "${response.reasonPhrase}"),
      ));
    } on SocketException catch (exception) {
      emit(
        state.copyWith(
          loading: false,
          event: FeedbackEvents.fail,
          exception: ExceptionModel(description: exception.message),
        ),
      );
    }
  }
}
