import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_helper/src/config/network/connectivity_config.dart';

import 'package:interview_helper/src/utils/extensions/to_percent.dart';

import '../../../domain/models/index.dart';
import '../../../utils/decorations/view_utils.dart';
import '../../widgets/index.dart';
import 'index.dart';

class BookView extends StatefulWidget {
  const BookView({
    super.key,
    required this.book,
    required this.index,
    required this.otherBooks,
    required this.category,
  });

  final Book book;
  final int index;
  final List<Book> otherBooks;
  final String category;

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> with _DownloaderMixin {
  @override
  void initState() {
    super.initState();
    allBooks = [...widget.otherBooks, widget.book];

    _streamSubscription = _checkCachedFile(widget.book.url).listen((fileInfo) {
      _checkStatus(fileInfo);
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  Stream<FileInfo?> _checkCachedFile(String url) {
    final streamFileInfo = DefaultCacheManager().getFileFromCache(url).asStream();
    return streamFileInfo;
  }

  void _deletefromCache(String url) async {
    DefaultCacheManager().removeFile(url).then((_) {
      detailsNotifier.value = detailsNotifier.value.copyWith(
        buttonText: _ButtonText.download.text,
        buttonColor: Colors.green,
        cached: false,
        path: '',
      );
    });
  }

  void _checkStatus(FileInfo? fileInfo) {
    setState(() {
      cached = fileInfo != null;
      detailsNotifier.value = detailsNotifier.value.copyWith(cached: cached);
      if (cached) {
        detailsNotifier.value = detailsNotifier.value.copyWith(
          buttonText: _ButtonText.open.text,
          buttonColor: Colors.grey,
          path: fileInfo?.file.path,
        );
      } else {
        detailsNotifier.value = detailsNotifier.value.copyWith(
          buttonText: _ButtonText.download.text,
        );
      }
    });
  }

  _onTap({required _Details details}) async {
    if (details.cached) {
      context.pushNamed(AppRouteConstant.openBook, extra: details.path);
    } else {
      final hasConnection = await ConnectivityService().hasActiveInternetConnection();
      if (!hasConnection) {
        return ViewUtils.showInterviewHelperSnackBar(
          snackbarTitle: 'A problem has occurred with the internet!',
          backgroundColor: Colors.red,
        );
      }

      downloadPdf(widget.book.url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category), centerTitle: false),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            Center(child: BookViewModel(book: widget.book).smallSizeBookView(context)),
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
                      onTap: () => _onTap(details: details),
                      details: details,
                    ),
                  ),
                  const SizedBox(width: 20),
                  if (details.cached)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width * .35,
                          child: ElevatedButton(
                            onPressed: () => _deletefromCache(widget.book.url),
                            style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll<Color>(Colors.red),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            child: Text(
                              'Delete',
                              style: ViewUtils.ubuntuStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
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
            CategoryCollection(
              allBooks: allBooks,
              otherBooks: widget.otherBooks,
              category: widget.category,
            )
          ],
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
      width: MediaQuery.sizeOf(context).width * .55,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(details.buttonColor),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        child: details.downloading
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CupertinoActivityIndicator(radius: 15, color: Colors.white),
                  const SizedBox(width: 7),
                  Text(details.process.toPercent(), style: ViewUtils.ubuntuStyle(fontSize: 18, color: Colors.white)),
                ],
              )
            : Text(
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
  final String path;
  final bool cached;

  _Details({
    required this.buttonColor,
    required this.process,
    required this.downloading,
    required this.buttonText,
    required this.path,
    required this.cached,
  });

  factory _Details.initial() {
    return _Details(
      buttonColor: Colors.green,
      process: 0,
      downloading: false,
      buttonText: '',
      path: '',
      cached: false,
    );
  }

  _Details copyWith({
    Color? buttonColor,
    double? process,
    bool? downloading,
    String? buttonText,
    String? path,
    bool? cached,
  }) {
    return _Details(
      buttonColor: buttonColor ?? this.buttonColor,
      process: process ?? this.process,
      path: path ?? this.path,
      downloading: downloading ?? this.downloading,
      buttonText: buttonText ?? this.buttonText,
      cached: cached ?? this.cached,
    );
  }
}

mixin _DownloaderMixin on State<BookView> {
  void downloadPdf(String url) {
    DefaultCacheManager().getFileStream(url, withProgress: true).listen((fileResponse) async {
      if (cached) {
        return;
      } else if (fileResponse is DownloadProgress) {
        // start downloading process
        final process = (fileResponse.downloaded / (fileResponse.totalSize ?? 0));
        detailsNotifier.value = detailsNotifier.value.copyWith(
          buttonText: _ButtonText.downloading.text,
          downloading: true,
          process: process,
        );
      } else if (fileResponse is FileInfo) {
        // when the downloading process has been completed
        detailsNotifier.value = detailsNotifier.value.copyWith(
          buttonText: _ButtonText.open.text,
          path: fileResponse.file.path,
          buttonColor: Colors.grey,
          downloading: false,
          cached: true,
        );
      }
    });
  }

  bool cached = false;

  late List<Book> allBooks;
  late StreamSubscription _streamSubscription;

  final detailsNotifier = ValueNotifier(_Details.initial());
}

enum _ButtonText {
  downloading(''),
  download('Download'),
  open('Open');

  final String text;
  const _ButtonText(this.text);
}
