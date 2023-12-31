part of 'introduction_bloc.dart';

class AppState {
  final bool? onboardingViewed;
  final bool loading;

  AppState({required this.onboardingViewed, required this.loading});

  AppState copyWith({bool? onboardingViewed, bool? loading}) {
    return AppState(
      onboardingViewed: onboardingViewed ?? this.onboardingViewed,
      loading: loading ?? this.loading,
    );
  }

  factory AppState.unknown() {
    return AppState(onboardingViewed: false, loading: false);
  }
}
