// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';

// abstract class ICacheManager {
//   Future<String> getCacheSize();
//   Future<void> clearAppCacheAndroid();
// }

// class CacheManager extends ICacheManager {
//   CacheManager();
//   @override
//   Future<void> clearAppCacheAndroid() async {
//     try {
//       Directory cacheDir = await getTemporaryDirectory();
//       if (cacheDir.existsSync()) {
//         cacheDir.deleteSync(recursive: true);
//       }
//     } catch (_) {}
//   }

//   String formatBytes(int bytes) {
//     if (bytes <= 0) return '0 B';
//     final List<String> units = ['B', 'KB', 'MB', 'GB', 'TB'];
//     int index = (log(bytes) / log(1024)).floor();
//     double size = bytes / pow(1024, index);
//     return '${size.toStringAsFixed(2)} ${units[index]}';
//   }

//   @override
//   Future<String> getCacheSize() async {
//     Directory tempDir = await getTemporaryDirectory();
//     int tempDirSize = _getSize(tempDir);
//     return formatBytes(tempDirSize);
//   }

//   int _getSize(FileSystemEntity file) {
//     if (file is File) {
//       return file.lengthSync();
//     } else if (file is Directory) {
//       int sum = 0;
//       List<FileSystemEntity> children = file.listSync();
//       for (FileSystemEntity child in children) {
//         sum += _getSize(child);
//       }
//       return sum;
//     }
//     return 0;
//   }
// }

// class ForIOS{
//   static const platform = MethodChannel('InterviewQuestions/cache');

//   Future<bool> checkCacheExistence() async {
//     return await platform.invokeMethod('checkCacheExistence');
//   }

//   Future<String> getTotalCacheSize() async {
//     return await platform.invokeMethod('getTotalCacheSize');
//   }

//   Future<String> formatBytes(int bytes) async {
//     return await platform.invokeMethod('formatBytes', bytes);
//   }

//   Future<void> clearCache() async {
//     await platform.invokeMethod('clearCache');
//   }

// }