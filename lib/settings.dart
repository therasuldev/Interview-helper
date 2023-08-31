import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/settings_tile.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';
import 'package:simple_app_cache_manager/simple_app_cache_manager.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).padding.top,
          horizontal: 15,
        ),
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
              style: ViewUtils.ubuntuStyle(color: Colors.red),
            ),
            onTap: () async {
              cacheManager.clearCache();
              updateCacheSize();
            },
            title: 'Clear cache',
            iconColor: Colors.orange,
          ),
        ],
      ),
    );
  }

  void updateCacheSize() async {
    final newSize = await cacheManager.getTotalCacheSize();
    setState(() => cacheSize = newSize);
  }
}
