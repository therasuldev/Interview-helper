import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/view/pages/home/categories.dart';
import 'package:flutter_interview_questions/view/pages/library/library.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  final List<Widget> pages = [
    const HomeCategories(),
    const Library(),
  ];

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

  void clearAppCacheAndroid() async {
    try {
      Directory cacheDir = await getTemporaryDirectory();
      if (cacheDir.existsSync()) {
        cacheDir.deleteSync(recursive: true);
      }
    } catch (e) {
      print("Error clearing cache: $e");
    }
  }

  bottomTapped(index) {
    setState(() => pageIdx = index);
  }

  int pageIdx = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: appBar(pageIdx),
        body: pages.elementAt(pageIdx),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: ViewUtils.ubuntuStyle(fontSize: 16),
          unselectedLabelStyle: ViewUtils.ubuntuStyle(fontSize: 14),
          selectedItemColor: const Color.fromARGB(255, 38, 109, 176),
          currentIndex: pageIdx,
          onTap: (idx) => bottomTapped(idx),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.auto_stories), label: 'Library'),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              FutureBuilder(
                future: getCacheSize(),
                builder: (ctx, sn) {
                  if (sn.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return Text(formatBytes(sn.data!));
                },
              ),
              ElevatedButton(
                onPressed: clearAppCacheAndroid,
                child: const Text('clear'),
              )
            ],
          ),
        ),
      );

  AppBar appBar(int pageIdx) {
    return AppBar(
      centerTitle: true,
      title: Text(
        pageIdx == 0 ? 'Categories' : 'Library',
        style: ViewUtils.ubuntuStyle(fontSize: 22),
      ),
      backgroundColor: const Color.fromARGB(255, 38, 109, 176),
    );
  }
}
