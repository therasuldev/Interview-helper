import 'package:dio/dio.dart';
import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

class BookStore extends StatefulWidget {
  const BookStore({super.key});

  @override
  State<BookStore> createState() => _BookStoreState();
}

class _BookStoreState extends State<BookStore> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        _RowTitleWidget(title: 'Flutter', onPressed: () {}),
        const _BookCardWidget(),
        //*
        _RowTitleWidget(title: 'Go Lang', onPressed: () {}),
        const _BookCardWidget(),
      ],
    );
  }
}

class _BookCardWidget extends StatefulWidget {
  const _BookCardWidget();

  @override
  State<_BookCardWidget> createState() => _BookCardWidgetState();
}

class _BookCardWidgetState extends State<_BookCardWidget> {
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
    if (isExs) setState(() => _isExists = isExs);
    return isExs;
  }

  Future downloadFile(int index, Reference ref) async {
    final url = await ref.getDownloadURL();

    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/${ref.name}';

    // for a file
    if (await existsFile(path)) return;

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
    return SizedBox(
      height: MediaQuery.of(context).size.height * .35,
      child: FutureBuilder<ListResult>(
        future: _futureFiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!.items;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: files.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final file = files[index];
                final progress = _downloadProgress[index];
                return Container(
                  margin: const EdgeInsets.all(5),
                  color: Colors.amber,
                  width: MediaQuery.of(context).size.width * .6,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .2,
                        child: const Placeholder(),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            file.name,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: ViewUtils.ubuntuStyle(),
                          ),
                          trailing: _isExists
                              ? const Icon(Icons.download_done)
                              : ElevatedButton(
                                  onPressed: () => downloadFile(index, file),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.green),
                                  ),
                                  child: const Text('download'),
                                ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('error occured'));
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class _RowTitleWidget extends StatelessWidget {
  const _RowTitleWidget({required this.title, required this.onPressed});

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: ViewUtils.ubuntuStyle(fontSize: 20)),
        TextButton(
          onPressed: onPressed,
          child: Text('All', style: ViewUtils.ubuntuStyle(fontSize: 20)),
        )
      ],
    );
  }
}
