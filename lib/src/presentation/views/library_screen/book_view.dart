import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';

import 'package:interview_helper/src/config/router/app_router.dart';
import 'package:interview_helper/src/utils/extensions/to_percent.dart';

import '../../../domain/models/models.dart';
import '../../../utils/decorations/view_utils.dart';
import '../../widgets/widgets.dart';
import 'library.dart';

class BookView extends StatefulWidget {
  const BookView({
    super.key,
    required this.book,
    required this.index,
    required this.otherBooks,
  });

  final Book book;
  final int index;
  final List<Book> otherBooks;

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> with _DownloaderMixin {
  @override
  void initState() {
    super.initState();
    allBooks = [...widget.otherBooks, widget.book];

    _streamSubscription = _checkCacheStatus(widget.book.url).listen((fileInfo) {
      _checkStatus(fileInfo);
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  Stream<FileInfo?> _checkCacheStatus(String url) {
    final streamFileInfo = DefaultCacheManager().getFileFromCache(url).asStream();
    return streamFileInfo;
  }

  void _checkStatus(FileInfo? fileInfo) {
    setState(() {
      cached = fileInfo != null;
      if (cached) {
        detailsNotifier.value = detailsNotifier.value.copyWith(
          buttonText: _ButtonText.open.text,
          buttonColor: Colors.grey,
        );
      } else {
        detailsNotifier.value = detailsNotifier.value.copyWith(
          buttonText: _ButtonText.download.text,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter'),
        centerTitle: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.pushNamed(AppRouteConstant.openBook, extra: widget.book),
                child: Center(child: BookViewModel(book: widget.book).smallSizeBookView(context)),
              ),
              const SizedBox(height: 20),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.book.name,
                    textAlign: TextAlign.center,
                    style: ViewUtils.ubuntuStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: detailsNotifier,
                builder: (context, details, child) => Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: _DynamicButton(
                        onTap: () => onProgress(widget.book.url),
                        details: details,
                      ),
                    ),
                    const SizedBox(width: 20),
                    if (details.downloading) CircularProgressIndicator(value: details.process.toDouble()),
                    const SizedBox(width: 20),
                    if (details.downloading) Text(details.process.toPercent(), style: ViewUtils.ubuntuStyle(fontSize: 18)),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Discover More from Flutter',
                  textAlign: TextAlign.center,
                  style: ViewUtils.ubuntuStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              CategoryCollection(allBooks: allBooks, otherBooks: widget.otherBooks)
            ],
          ),
        ),
      ),
    );
  }
}

class _DynamicButton extends StatelessWidget {
  const _DynamicButton({
    required this.onTap,
    required this.details,
  });

  final VoidCallback? onTap;
  final _Details details;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.sizeOf(context).width * .45,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(details.buttonColor),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        child: Text(
          details.buttonText,
          style: ViewUtils.ubuntuStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

class _Details {
  final Color buttonColor;
  final double process;
  final bool downloading;
  final String buttonText;

  _Details({
    required this.buttonColor,
    required this.process,
    required this.downloading,
    required this.buttonText,
  });

  factory _Details.initial() {
    return _Details(
      buttonColor: Colors.green,
      process: 0,
      downloading: false,
      buttonText: '',
    );
  }

  _Details copyWith({
    Color? buttonColor,
    double? process,
    bool? downloading,
    String? buttonText,
  }) {
    return _Details(
      buttonColor: buttonColor ?? this.buttonColor,
      process: process ?? this.process,
      downloading: downloading ?? this.downloading,
      buttonText: buttonText ?? this.buttonText,
    );
  }
}

mixin _DownloaderMixin on State<BookView> {
  void onProgress(String url) {
    DefaultCacheManager().getFileStream(url, withProgress: true).listen((fileResponse) async {
      if (cached) {
        // the file has been downloaded
        detailsNotifier.value = detailsNotifier.value.copyWith(
          buttonText: _ButtonText.open.text,
          buttonColor: Colors.grey,
        );
        return;
      } else if (fileResponse is DownloadProgress) {
        // start process
        detailsNotifier.value = detailsNotifier.value.copyWith(downloading: true, buttonText: _ButtonText.downloading.text);
        final process = (fileResponse.downloaded / (fileResponse.totalSize ?? 0));
        detailsNotifier.value = detailsNotifier.value.copyWith(process: process);
      } else if (fileResponse is FileInfo) {
        // when the downloading process has been completed
        detailsNotifier.value = detailsNotifier.value.copyWith(downloading: false, buttonColor: Colors.grey, buttonText: 'Open');
      }
    });
  }

  bool cached = false;

  late List<Book> allBooks;
  late StreamSubscription _streamSubscription;

  final detailsNotifier = ValueNotifier(_Details.initial());
}

enum _ButtonText {
  downloading('Downloading...'),
  download('Download'),
  open('Open');

  final String text;
  const _ButtonText(this.text);
}
