import 'package:app_settings/app_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_helper/src/presentation/provider/cubit/language/language_cubit.dart';
import 'package:interview_helper/src/utils/index.dart';
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
            changeAppLanguage(),
            notificationCard(),
            clearCacheCard(),
            const Spacer(),
            showAppVersion(),
          ],
        ),
      ),
    );
  }

  Widget changeAppLanguage() {
    return SettingTile(
      icon: const Icon(size: 20, color: Colors.white, Icons.language),
      tralling: ValueListenableBuilder(
        valueListenable: notificationPrefsNotifier,
        builder: (context, isEnabled, child) {
          return _buildPopUpMenu();
        },
      ),
      title: 'Notifications',
      iconColor: Colors.blueGrey,
    );
  }

  Widget _buildPopUpMenu() {
    // Build the popup menu for language selection
    return Theme(
      data: ThemeData(
        useMaterial3: false,
        popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
      ),
      child: PopUpMenuBar(
        baseIcon: Icons.select_all,
        iconColor: AppColors.primary,
        items: const [
          PopUpMenuBarItem(
            title: 'EN',
            tralling: Text('🇬🇧', style: TextStyle(fontSize: 20)),
          ),
          PopUpMenuBarItem(
            title: 'RU',
            tralling: Text('🇷🇺', style: TextStyle(fontSize: 20)),
          ),
          PopUpMenuBarItem(
            title: 'TR',
            tralling: Text('🇹🇷', style: TextStyle(fontSize: 20)),
          ),
        ],
        onSelect: (i) async {
          final values = {0: 'en', 1: 'ru', 2: 'tr'};
          if (context.locale.languageCode == values[i]) return;
          var langCubit = context.read<LanguageCubit>();
          langCubit.setLanguage(values[i]!, context);
        },
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

// An item object for [PopUpMenuBar].
class PopUpMenuBarItem {
  final String title;
  final Widget tralling;

  const PopUpMenuBarItem({required this.title, required this.tralling});
}

// A modified pop up menu widget.
class PopUpMenuBar extends StatelessWidget {
  final List<PopUpMenuBarItem> items;
  final Function(int index) onSelect;
  final IconData baseIcon;
  final BorderRadius radius;
  final Color iconColor;
  final BorderSide border;

  const PopUpMenuBar({
    super.key,
    required this.items,
    required this.onSelect,
    this.baseIcon = Icons.more_vert,
    this.radius = const BorderRadius.only(
      topLeft: Radius.circular(25),
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    ),
    this.iconColor = Colors.black,
    this.border = BorderSide.none,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      key: const Key('popUpMenuBar.widget'),
      shape: RoundedRectangleBorder(borderRadius: radius, side: border),
      icon: Icon(baseIcon, color: iconColor),
      onSelected: onSelect,
      itemBuilder: (context) => [
        for (var i = 0; i < items.length; i++)
          PopupMenuItem(
            key: Key('popUpMenuItem.$i'),
            value: i,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  items[i].tralling,
                  const SizedBox(width: 10),
                  Text(items[i].title),
                ],
              ),
            ),
          )
      ],
    );
  }
}
