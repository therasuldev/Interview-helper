import 'package:dio/dio.dart';
import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

class BookView extends StatefulWidget {
  const BookView({super.key});

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  final Map<int, double> _downloadProgress = {};
  late Future<ListResult> _futureFiles;
  bool _isCompleted = false;
  bool _isExists = false;

  @override
  void initState() {
    super.initState();
    _futureFiles = FirebaseStorage.instance.ref('/golang').listAll();
  }

  Future<bool> existsFile(String path) async {
    final isExs = await io.File(path).exists();
    if (isExs) setState(() => _isExists = true);
    return isExs;
  }

  Future downloadFile(int index, Reference ref) async {
    final url = await ref.getDownloadURL();

    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/${ref.name}';

    // for a file
    if(await existsFile(path)) return;

    await Dio().download(
      url,
      path,
      onReceiveProgress: (count, total) {
        double progress = count / total;
        setState(() => _downloadProgress[index] = progress);
      },
    ).whenComplete(() => setState(() => _isCompleted = true));
  }

  Widget? subtitleWidget(double? progress) {
    if (progress == null) return null;
    if (!_isCompleted) return LinearProgressIndicator(value: progress);
    return null;
  }

  Widget? downloadIcon(int index, Reference ref, double? progress) {
    if (!_isCompleted && progress == null) {
      return IconButton(
        onPressed: () => downloadFile(index, ref),
        icon: const Icon(Icons.download),
      );
    }
    if (!_isCompleted && progress != null) {
      return Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Text((progress * 100).round().toString()),
      );
    }
    return const Icon(Icons.download_done_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 20),
          child: Row(
            children: [
              const Spacer(),
              const SizedBox(
                height: 150,
                width: 150,
                child: Placeholder(),
              ),
              const Spacer(),
              Expanded(
                flex: 3,
                child: Text(
                  'Flutter 2023, new book Dart&Flutter',
                  style: ViewUtils.ubuntuStyle(),
                  maxLines: 5,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            // SizedBox(
            //   width: MediaQuery.of(context).size.width * .7,
            //   child: ElevatedButton(
            //     onPressed: () => downloadFile(),
            //     style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.all(Colors.green),
            //     ),
            //     child: const Text('download'),
            //   ),
            // ),
            FutureBuilder<ListResult>(
              future: _futureFiles,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final files = snapshot.data!.items;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      final file = files[index];
                      final double? progress = _downloadProgress[index];
                      return ListTile(
                        title: Text(file.name),
                        subtitle: subtitleWidget(progress),
                        trailing: _isExists
                            ? IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.download_done))
                            : ElevatedButton(
                                onPressed: () => downloadFile(index, file),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.green),
                                ),
                                child: const Text('download'),
                              ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('error occured'));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
