import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_interview_questions/core/model/email/emailjs.dart';
import 'package:flutter_interview_questions/core/model/error/error_model.dart';

import 'package:http/http.dart' as http;

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit() : super(FeedbackState.unknown);

  void send({required MSGParams params}) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final emailJS = EmailJS(msgParams: params);

    final headers = {
      'origin': 'http://localhost',
      'Content-Type': 'application/json'
    };

    try {
      emit(state.copyWith(
        loading: true,
        event: FeedbackEvents.start,
      ));

      final response = await http.post(
        url,
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
        event: FeedbackEvents.faile,
        exception: ExceptionModel(description: "${response.reasonPhrase}"),
      ));
    } on SocketException catch (exception) {
      emit(
        state.copyWith(
          loading: false,
          event: FeedbackEvents.faile,
          exception: ExceptionModel(description: exception.message),
        ),
      );
    }
  }
}
