import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_questions/app_navigators.dart';
import 'package:flutter_interview_questions/core/local_service/cache_service.dart';
import 'package:flutter_interview_questions/core/utils/enum.dart';
import 'package:flutter_interview_questions/view/pages/library/all_items/all_books.dart';
import 'package:flutter_interview_questions/view/pages/library/book_view.dart';
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
              //* Flutter
              _RowTitleWidget(
                title: Titles.flutter.title,
                page: AllBooks(books: state.library![0][Types.flutter.type]!),
              ),
              _BookCardWidget(books: state.library![0][Types.flutter.type]!),

              //* Go
              _RowTitleWidget(
                title: Titles.go.title,
                page: AllBooks(books: state.library![1][Types.go.type]!),
              ),
              _BookCardWidget(books: state.library![1][Types.go.type]!)
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
  final List<Book> books;

  @override
  State<_BookCardWidget> createState() => _BookCardWidgetState();
}

class _BookCardWidgetState extends State<_BookCardWidget> {
  //when proceed the downloading prosses
  bool _isProceed = false;

  final Map<int, double> _downloadProgress = {};
  final CacheService _cacheService = CacheService();

  Future downloadFile(int index, Book book) async {
    final url = await book.url;
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/${book.name}';

    await Dio().download(
      url,
      path,
      onReceiveProgress: (count, total) {
        double progress = count / total;
        setState(() {
          _isProceed = true;
          _downloadProgress[index] = progress;
        });
      },
    ).whenComplete(() async {
      await _cacheService.downloadedBooks.put(book.name, book.name);
      setState(() => _isProceed = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .35,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.books.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final book = widget.books[index];
          final existsBookName = _cacheService.downloadedBooks.get(book.name);
          final isDownloaded = book.name == existsBookName;

          return GestureDetector(
            child: _BookCard(
              bookName: book.name,
              isProceed: _isProceed,
              isDownloaded: isDownloaded,
              progressValue: _downloadProgress[index],
              onPressed: () async => await downloadFile(index, book),
            ),
            onTap: () {
              final otherBooks = widget.books.where((b) => b != book).toList();
              AppNavigators.go(
                context,
                BookView(book: book, otherBooks: otherBooks),
              );
            },
          );
        },
      ),
    );
  }
}

class _BookCard extends StatelessWidget {
  const _BookCard({
    required bool isDownloaded,
    required bool isProceed,
    required String bookName,
    required double? progressValue,
    required void Function()? onPressed,
  })  : _isDownloaded = isDownloaded,
        _isProceed = isProceed,
        _bookName = bookName,
        _progressValue = progressValue,
        _onPressed = onPressed;

  final bool _isDownloaded;
  final bool _isProceed;
  final String _bookName;
  final double? _progressValue;
  final void Function()? _onPressed;

  Widget? subtitleWidget() {
    if (_progressValue != null && _isProceed) {
      return LinearProgressIndicator(value: _progressValue);
    }
    if (_progressValue != null && !_isProceed) return null;
    return null;
  }

  Widget? trailingWidget() {
    if (_isDownloaded) return const Icon(Icons.download_done);
    return ElevatedButton(
      onPressed: _onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),
      ),
      child: const Text('download'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      color: Colors.pink,
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.width * .5,
            color: Colors.yellow,
            child: const Placeholder(),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Text(
              _bookName,
              textAlign: TextAlign.center,
              style: ViewUtils.ubuntuStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}

class _RowTitleWidget extends StatelessWidget {
  const _RowTitleWidget({
    required this.page,
    required this.title,
  });

  final Widget page;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: ViewUtils.ubuntuStyle(fontSize: 20)),
        TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) => page), (route) => true);
          },
          child: Text('All', style: ViewUtils.ubuntuStyle(fontSize: 20)),
        )
      ],
    );
  }
}
