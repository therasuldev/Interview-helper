import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/gen/assets.gen.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

class BookStore extends StatefulWidget {
  const BookStore({super.key});

  @override
  State<BookStore> createState() => _BookStoreState();
}

class _BookStoreState extends State<BookStore> {
  Map<int, double> downloadProgress = {};
  late Future<ListResult> futureFiles;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/golang').listAll();
  }

  Future downloadFile(int index, Reference ref) async {
    final url = await ref.getDownloadURL();

    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/${ref.name}';

    await Dio().download(
      url,
      path,
      onReceiveProgress: (count, total) {
        double progress = count / total;
        setState(() => downloadProgress[index] = progress);
      },
    ).whenComplete(() => setState(() => isCompleted = true));
  }

  Widget? subtitleWidget(double? progress) {
    if (progress == null) return null;
    if (!isCompleted) return LinearProgressIndicator(value: progress);
    return null;
  }

  Widget? downloadIcon(int index, Reference ref, double? progress) {
    if (!isCompleted && progress == null) {
      return IconButton(
        onPressed: () => downloadFile(index, ref),
        icon: const Icon(Icons.download),
      );
    }
    if (!isCompleted && progress != null) {
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

// FutureBuilder<ListResult>(
//           future: futureFiles,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               final files = snapshot.data!.items;
//               return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: files.length,
//                 itemBuilder: (context, index) {
//                   final file = files[index];
//                   final double? progress = downloadProgress[index];
//                   return ListTile(
//                       title: Text(file.name),
//                       subtitle: subtitleWidget(progress),
//                       trailing: downloadIcon(index, file, progress));
//                 },
//               );
//             } else if (snapshot.hasError) {
//               return const Center(child: Text('error occured'));
//             } else {
//               return const SizedBox.shrink();
//             }
//           },
//         ),

class _BookCardWidget extends StatelessWidget {
  const _BookCardWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 15, bottom: 7, top: 7),
            width: 180,
            decoration: ViewUtils.categoryCard(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  width: 100,
                  child: Image.asset(
                    Assets.programmingLangPng.java.path,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Java book',
                      style: ViewUtils.ubuntuStyle(fontSize: 17),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.download),
                    )
                  ],
                )
              ],
            ),
          );
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
