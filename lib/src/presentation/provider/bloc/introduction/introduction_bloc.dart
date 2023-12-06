import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_for_interview/src/data/datasources/local/application_prefs.dart';
import 'package:prepare_for_interview/src/presentation/provider/bloc/introduction/introduction_event.dart';
import 'package:prepare_for_interview/src/presentation/provider/bloc/introduction/introduction_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : prefsImpl = ApplicationPrefsImpl(),
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
    final onboardingIsViewed = await prefsImpl.getValue();
    emit(state.copyWith(onboardingViewed: onboardingIsViewed, loading: false));
  }

  void _setState(AppEvent event) async {
    emit(state.copyWith(loading: true));
    await prefsImpl.setValue(event.payload);

    final onboardingIsViewed = await prefsImpl.getValue();
    emit(state.copyWith(onboardingViewed: onboardingIsViewed, loading: false));
  }

  late ApplicationPrefsImpl prefsImpl;
}
