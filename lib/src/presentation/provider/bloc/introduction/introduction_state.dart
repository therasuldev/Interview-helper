class AppState {
  final bool? onboardingViewed;

  AppState({required this.onboardingViewed});

  AppState copyWith({bool? onboardingViewed, bool? loading}) {
    return AppState(
      onboardingViewed: onboardingViewed ?? this.onboardingViewed,
    );
  }

  factory AppState.unknown() {
    return AppState(onboardingViewed: false);
  }
}
