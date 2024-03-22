import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_helper/gen/assets.gen.dart';
import 'package:interview_helper/src/config/network/connectivity_config.dart';

import 'package:interview_helper/src/domain/models/index.dart';
import 'package:interview_helper/src/presentation/provider/bloc/category/category_bloc.dart';
import 'package:interview_helper/src/presentation/widgets/index.dart';
import 'package:interview_helper/src/utils/index.dart';

import 'index.dart';

class BookmarkedBookViewing extends StatefulWidget {
  const BookmarkedBookViewing({
    super.key,
    required this.book,
    required this.category,
  });
  final Book book;
  final String category;

  @override
  State<BookmarkedBookViewing> createState() => _BookmarkedBookViewingState();
}

class _BookmarkedBookViewingState extends State<BookmarkedBookViewing> {
  @override
  void initState() {
    super.initState();

    _streamSubscription = _checkCachedFile(widget.book.url).listen((fileInfo) {
      _checkStatus(fileInfo);
    });
    context.read<CategoryBloc>().add(CategoryEvent.fetchBookmarkedBooksForCategory(widget.category));
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

  void _checkStatus(FileInfo? fileInfo) {
    setState(() {
      cached = fileInfo != null;
      detailsNotifier.value = detailsNotifier.value.copyWith(cached: cached);
      if (cached) {
        detailsNotifier.value = detailsNotifier.value.copyWith(
          buttonText: ButtonText.open.text,
          buttonColor: Colors.grey,
          path: fileInfo?.file.path,
        );
      } else {
        detailsNotifier.value = detailsNotifier.value.copyWith(
          buttonText: ButtonText.download.text,
        );
      }
    });
  }

  void _deletefromCache(String url) async {
    DefaultCacheManager().removeFile(url).then((_) {
      detailsNotifier.value = detailsNotifier.value.copyWith(
        buttonText: ButtonText.download.text,
        buttonColor: Colors.green,
        cached: false,
        path: '',
      );
    });
  }

  void _onTap({required Details details}) async {
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

  void downloadPdf(String url) {
    DefaultCacheManager().getFileStream(url, withProgress: true).listen((fileResponse) async {
      if (fileResponse is DownloadProgress) {
        // start downloading process
        final process = (fileResponse.downloaded / (fileResponse.totalSize ?? 0));
        detailsNotifier.value = detailsNotifier.value.copyWith(
          buttonText: ButtonText.downloading.text,
          downloading: true,
          process: process,
        );
      } else if (fileResponse is FileInfo) {
        // when the downloading process has been completed
        detailsNotifier.value = detailsNotifier.value.copyWith(
          buttonText: ButtonText.open.text,
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

  final detailsNotifier = ValueNotifier(Details.initial());

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width * 0.5;
    final double height = MediaQuery.sizeOf(context).height * 0.3;
    return Scaffold(
      appBar: AppBar(title: Text(widget.book.name), centerTitle: false),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Center(
            child: Hero(
              tag: widget.book.name,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: height,
                    width: width,
                    child: CachedNetworkImage(
                      imageUrl: widget.book.imageUrl,
                      progressIndicatorBuilder: (context, url, progress) {
                        return const KShimmer();
                      },
                      errorWidget: (context, url, error) {
                        return Transform.scale(
                          scale: .2,
                          child: SvgPicture.asset(Assets.svg.connectionLost),
                        );
                      },
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
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
            builder: (context, details, child) => BookActionButtonRow(
              book: widget.book,
              category: widget.category,
              details: details,
              bookUrl: widget.book.url,
              onTap: () => _onTap(details: details),
              onDelete: () => _deletefromCache(widget.book.url),
            ),
          ),
        ],
      ),
    );
  }
}
