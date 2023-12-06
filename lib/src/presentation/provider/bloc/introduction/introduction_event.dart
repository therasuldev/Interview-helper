enum AppEvents { startSet, startGet }

class AppEvent {
  AppEvents? type;
  dynamic payload;

  AppEvent.set(bool value) {
    type = AppEvents.startSet;
    payload = value;
  }

  AppEvent.get() {
    type = AppEvents.startGet;
  }
}
