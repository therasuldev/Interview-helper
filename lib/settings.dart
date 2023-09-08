import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_prep/settings_tile.dart';
import 'package:interview_prep/view/utils/utils.dart';
import 'package:simple_app_cache_manager/simple_app_cache_manager.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool switchVal = false;
  String cacheSize = '';
  late final SimpleAppCacheManager cacheManager;

  @override
  void initState() {
    super.initState();
    cacheManager = SimpleAppCacheManager();
    updateCacheSize();
  }

  @override
  void didUpdateWidget(Settings oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateCacheSize();
  }

  void updateCacheSize() async {
    final newSize = await cacheManager.getTotalCacheSize();
    setState(() => cacheSize = newSize);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          children: [
            const SizedBox(height: 10),
            Text('Settings', style: ViewUtils.ubuntuStyle(fontSize: 25)),
            const SizedBox(height: 10),
            SettingTile(
              icon: const Icon(
                size: 20,
                color: Colors.white,
                Icons.edit_attributes_rounded,
              ),
              tralling: Text(
                cacheSize.toString(),
                style: ViewUtils.ubuntuStyle(color: Colors.red, fontSize: 19),
              ),
              onTap: () async {
                cacheManager.clearCache();
                updateCacheSize();
              },
              title: 'Clear cache',
              iconColor: Colors.orange,
            ),
            SettingTile(
              icon: const Icon(
                size: 20,
                color: Colors.white,
                Icons.notifications,
              ),
              tralling: CupertinoSwitch(
                value: switchVal,
                activeColor: Colors.green,
                onChanged: (val) => setState(() => switchVal = val),
              ),
              title: 'Notifications',
              iconColor: Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }
}
