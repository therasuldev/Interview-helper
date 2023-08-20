import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/settings_tile.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int cacheSize = 0;

  @override
  void initState() {
    super.initState();
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
              formatBytes(cacheSize),
              style: ViewUtils.ubuntuStyle(color: Colors.red),
            ),
            onTap: () async {
              await clearAppCacheAndroid();
              updateCacheSize();
            },
            title: 'Clear cache',
            iconColor: Colors.orange,
          ),
        ],
      ),
    );
  }

  String formatBytes(int bytes) {
    if (bytes <= 0) return '0 B';
    final List<String> units = ['B', 'KB', 'MB', 'GB', 'TB'];
    int index = (log(bytes) / log(1024)).floor();
    double size = bytes / pow(1024, index);
    return '${size.toStringAsFixed(2)} ${units[index]}';
  }

  Future<int> getCacheSize() async {
    Directory tempDir = await getTemporaryDirectory();
    int tempDirSize = _getSize(tempDir);
    return tempDirSize;
  }

  int _getSize(FileSystemEntity file) {
    if (file is File) {
      return file.lengthSync();
    } else if (file is Directory) {
      int sum = 0;
      List<FileSystemEntity> children = file.listSync();
      for (FileSystemEntity child in children) {
        sum += _getSize(child);
      }
      return sum;
    }
    return 0;
  }

  Future<void> clearAppCacheAndroid() async {
    try {
      Directory cacheDir = await getTemporaryDirectory();
      if (cacheDir.existsSync()) {
        cacheDir.deleteSync(recursive: true);
      }
    } catch (_) {}
  }

  void updateCacheSize() async {
    int newSize = await getCacheSize();
    setState(() => cacheSize = newSize);
  }
}
