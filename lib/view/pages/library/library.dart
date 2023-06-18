import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_interview_questions/core/model/book/book.dart';
import 'package:flutter_interview_questions/core/provider/books_bloc/books_bloc.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';

class BookStore extends StatefulWidget {
  const BookStore({super.key});

  @override
  State<BookStore> createState() => _BookStoreState();
}

class _BookStoreState extends State<BookStore> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        if (state.loading!) {
          return const CircularProgressIndicator();
        } else if (!state.loading!) {
          return ListView(
            shrinkWrap: true,
            children: [
              _RowTitleWidget(title: 'Flutter', onPressed: () {}),
              _BookCardWidget(books: state.library![0]['flutter']),

              //*
              _RowTitleWidget(title: 'Go Lang', onPressed: () {}),
              _BookCardWidget(books: state.library![1]['go'])
            ],
          );
        } else {
          return Center(child: Text(state.error.toString()));
        }
      },
    );
  }
}

class _BookCardWidget extends StatefulWidget {
  const _BookCardWidget({
    Key? key,
    required this.books,
  }) : super(key: key);
  final List<Book>? books;

  @override
  State<_BookCardWidget> createState() => _BookCardWidgetState();
}

class _BookCardWidgetState extends State<_BookCardWidget> {
  final Map<int, double> _downloadProgress = {};
  //late Future<ListResult> _futureFiles;
  bool _isCompleted = false;
  bool _isDownloaded = false;

  path1() async {
    final tempDir = await getTemporaryDirectory();
  }

  Future<bool> existsFile(String path) async {
    final isDwnd = await io.File(path).exists();
    if (isDwnd) setState(() => _isDownloaded = isDwnd);
    return isDwnd;
  }

  Future downloadFile(int index, Book book) async {
    final url = await book.url;
    final temp = await getTemporaryDirectory();

    final path = '${temp.path}/${book.name}';

    // for a exists file
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

  Widget? downloadIcon(int index, Book book, double? progress) {
    if (!_isCompleted && progress == null) {
      return IconButton(
        onPressed: () => downloadFile(index, book),
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

  Future<bool> isfullPath(Book book) async {
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${book.name}';
    final isDwnd = await io.File(path).exists();
    return isDwnd;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * .35,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.books?.length ?? 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final book = widget.books![index];
            final progress = _downloadProgress[index];
            isfullPath(book).then((value) {
              _isDownloaded = value;
            });
            return BookCard(
              bookName: book.name,
              isDownloaded: _isDownloaded,
              onPressed: () {},
            );
          },
        ));
  }
}

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required bool isDownloaded,
    required String bookName,
    required void Function()? onPressed,
  })  : _isDownloaded = isDownloaded,
        _bookName = bookName,
        _onPressed = onPressed;

  final bool _isDownloaded;
  final String _bookName;
  final void Function()? _onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      color: Color.fromARGB(255, 197, 201, 224),
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
                _bookName,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: ViewUtils.ubuntuStyle(),
              ),
              //subtitle: subtitleWidget(progress),
              trailing: _isDownloaded
                  ? const Icon(Icons.download_done)
                  : ElevatedButton(
                      onPressed: _onPressed,
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
