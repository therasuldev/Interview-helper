import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:prepare_for_interview/src/config/network/network_manager.dart';

import '../../../../data/datasources/base/api_config.dart';
import '../../../../domain/models/models.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit()
      : _connectivityService = ConnectivityService(),
        super(FeedbackState.unknown());

  void send({required Message message}) async {
    final emailJS = EmailJS(message: message);

    final isConnected = await _connectivityService.getConnectivityStatus();
    if (!isConnected) return null;

    try {
      emit(state.copyWith(loading: true));

      final response = await http.post(
        ApiConfig().api,
        headers: ApiConfig().headers,
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
        event: FeedbackEvents.failure,
        exception: ExceptionModel(description: "${response.reasonPhrase}"),
      ));
    } on SocketException catch (exception) {
      emit(
        state.copyWith(
          loading: false,
          event: FeedbackEvents.failure,
          exception: ExceptionModel(description: exception.message),
        ),
      );
    }
  }

  late final ConnectivityService _connectivityService;
}
