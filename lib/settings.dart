import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_prep/core/service/shared_pref.dart';
import 'package:interview_prep/settings_tile.dart';
import 'package:interview_prep/view/utils/utils.dart';
import 'package:simple_app_cache_manager/simple_app_cache_manager.dart';
import 'package:version_tracker/version_tracker.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
    with CacheMixin, VersionMixin, NotificationMixin {
  bool switchVal = false;

  @override
  void initState() {
    super.initState();

    cacheManager = SimpleAppCacheManager();
    updateCacheSize();

    versionTracker = VersionTracker();
    updateVersion();

    prefs = NotificationPrefs();
    updateNotificationSettings();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text('Settings', style: ViewUtils.ubuntuStyle(fontSize: 25)),
              const SizedBox(height: 10),
              clearCacheCard(),
              notificationCard(prefs),
              const Spacer(),
              showAppVersion()
            ],
          ),
        ),
      ),
    );
  }

  Widget clearCacheCard() => SettingTile(
        icon: const Icon(
          size: 20,
          color: Colors.white,
          Icons.edit_attributes_rounded,
        ),
        tralling: ValueListenableBuilder(
          valueListenable: cacheSizeNotifier,
          builder: (context, cacheSize, child) => Text(
            cacheSize,
            style: ViewUtils.ubuntuStyle(color: Colors.red, fontSize: 19),
          ),
        ),
        onTap: () async {
          cacheManager.clearCache();
          updateCacheSize();
        },
        title: 'Clear cache',
        iconColor: Colors.orange,
      );

  Widget notificationCard(NotificationPrefs prefs) => SettingTile(
        icon: const Icon(size: 20, color: Colors.white, Icons.notifications),
        tralling: ValueListenableBuilder(
          valueListenable: prefsNotifier,
          builder: (context, isEnabled, child) {
            return CupertinoSwitch(
              value: isEnabled,
              activeColor: Colors.green,
              onChanged: (isEnabled) async {
                prefs.notificationCtrlSet(isEnabled);
                updateNotificationSettings();
              },
            );
          },
        ),
        title: 'Notifications',
        iconColor: Colors.blueGrey,
      );

  Widget showAppVersion() => Center(
        child: ValueListenableBuilder(
          valueListenable: versionNotifier,
          builder: (context, version, child) {
            return Text(
              "v$version",
              style: ViewUtils.ubuntuStyle(fontSize: 18),
            );
          },
        ),
      );
}

mixin CacheMixin on State<Settings> {
  late final SimpleAppCacheManager cacheManager;
  final cacheSizeNotifier = ValueNotifier<String>('');

  void updateCacheSize() async {
    final cacheSize = await cacheManager.getTotalCacheSize();
    cacheSizeNotifier.value = cacheSize;
  }
}

mixin VersionMixin on State<Settings> {
  late final VersionTracker versionTracker;
  final versionNotifier = ValueNotifier<String>('');

  void updateVersion() async {
    await versionTracker.track();
    versionNotifier.value = versionTracker.currentVersion!;
  }
}

mixin NotificationMixin on State<Settings> {
  late final NotificationPrefs prefs;
  final prefsNotifier = ValueNotifier<bool>(false);

  void updateNotificationSettings() async {
    var isEnabled = await prefs.notificationCtrlGet();
    prefsNotifier.value = isEnabled ?? false;
  }
}
