// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_helper/src/data/datasources/local/application_prefs.dart';

part 'introduction_event.dart';
part 'introduction_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : prefsImpl = AppIntroductionPrefsImpl(),
        super(AppState.unknown()) {
    on<AppEvent>((event, emit) {
      switch (event.type) {
        case AppEvents.startSet:
          _setState(event);
          break;
        case AppEvents.startGet:
          _getState();
        default:
      }
    });
  }
  void _getState() async {
    emit(state.copyWith(loading: true));
    final onboardingIsViewed = await prefsImpl.getIntroducedState();
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(onboardingViewed: onboardingIsViewed, loading: false));
  }

  void _setState(AppEvent event) async {
    emit(state.copyWith(loading: true));
    await prefsImpl.setIntroducedState(event.payload);

    final onboardingIsViewed = await prefsImpl.getIntroducedState();
    emit(state.copyWith(onboardingViewed: onboardingIsViewed, loading: false));
  }

  late AppIntroductionPrefsImpl prefsImpl;
}
