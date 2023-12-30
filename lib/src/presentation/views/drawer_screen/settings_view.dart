import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_app_cache_manager/simple_app_cache_manager.dart';
import 'package:version_tracker/version_tracker.dart';

import 'package:interview_helper/src/data/datasources/local/notification_prefs_service.dart';

import '../../../utils/decorations/view_utils.dart';
import '../../widgets/index.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with WidgetsBindingObserver, CacheMixin, VersionMixin, NotificationMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    notificationPrefs = NotificationPrefsServiceImpl();
    updateNotificationSettings();

    cacheManager = SimpleAppCacheManager();
    updateCacheSize();

    versionTracker = VersionTracker();
    updateVersion();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Re-check notification permission when app is resumed
      recheckNotificationPermission();
    }
  }

  void recheckNotificationPermission() async {
    notificationPrefs.askPermission().then((status) {
      notificationPrefs.getNotificationState().then((status) {
        updateNotificationSettings(status: status);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: false),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            clearCacheCard(),
            notificationCard(),
            const Spacer(),
            showAppVersion(),
          ],
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
            style: ViewUtils.ubuntuStyle(
              color: Colors.red,
              fontSize: 19,
            ),
          ),
        ),
        onTap: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return _AlertDialog(
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'Yes',
                      style: ViewUtils.ubuntuStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      cacheManager.clearCache();
                      updateCacheSize();
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('No', style: ViewUtils.ubuntuStyle(color: Colors.black)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
          );
        },
        title: 'Clear cache',
        iconColor: Colors.orange,
      );

  Widget notificationCard() {
    return SettingTile(
      icon: const Icon(size: 20, color: Colors.white, Icons.notifications),
      tralling: ValueListenableBuilder(
        valueListenable: notificationPrefsNotifier,
        builder: (context, isEnabled, child) {
          return Switch(
            value: isEnabled,
            activeColor: Colors.green,
            inactiveTrackColor: Colors.transparent,
            onChanged: (state) async {
              AppSettings.openAppSettings(type: AppSettingsType.notification);
            },
          );
        },
      ),
      title: 'Notifications',
      iconColor: Colors.blueGrey,
    );
  }

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

class _AlertDialog extends StatelessWidget {
  const _AlertDialog({required this.actions});

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final style = ViewUtils.ubuntuStyle(color: Colors.black);
    const subtitle = 'All interrupted questions and books will be permanently deleted.';

    return Theme(
      data: ThemeData(
        useMaterial3: false,
        colorScheme: const ColorScheme.light(),
      ),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text('Clear cache?', style: style),
        content: SingleChildScrollView(
          child: ListBody(children: <Widget>[Text(subtitle, style: style)]),
        ),
        actions: actions,
      ),
    );
  }
}

mixin CacheMixin on State<SettingsView> {
  late final SimpleAppCacheManager cacheManager;
  final cacheSizeNotifier = ValueNotifier<String>('');

  void updateCacheSize() async {
    final cacheSize = await cacheManager.getTotalCacheSize();
    cacheSizeNotifier.value = cacheSize;
  }
}

mixin VersionMixin on State<SettingsView> {
  late final VersionTracker versionTracker;
  final versionNotifier = ValueNotifier<String>('');

  void updateVersion() async {
    await versionTracker.track();
    versionNotifier.value = versionTracker.currentVersion!;
  }
}

mixin NotificationMixin on State<SettingsView> {
  late final NotificationPrefsServiceImpl notificationPrefs;
  final notificationPrefsNotifier = ValueNotifier<bool>(false);

  void updateNotificationSettings({bool? status}) async {
    var isEnabled = await notificationPrefs.getNotificationState();
    notificationPrefsNotifier.value = status ?? isEnabled ?? false;
  }
}
