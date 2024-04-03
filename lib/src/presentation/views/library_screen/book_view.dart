import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:interview_helper/gen/assets.gen.dart';
import 'package:interview_helper/src/config/network/connectivity_config.dart';
import 'package:interview_helper/src/presentation/provider/bloc/category/category_bloc.dart';

import '../../../domain/models/index.dart';
import '../../../utils/index.dart';
import '../../widgets/index.dart';
import 'index.dart';

class BookView extends StatefulWidget {
  const BookView({
    super.key,
    required this.book,
    required this.otherBooks,
    required this.category,
  });

  final Book book;

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

  void _onTap({required Details details}) async {
    if (details.cached) {
      context.pushNamed(AppRouteConstant.openBook, extra: details.path);
    } else {
      final hasConnection = await ConnectivityService().hasActiveInternetConnection();
      if (!hasConnection) {
        return ViewUtils.showInterviewHelperSnackBar(
          snackbarTitle: 'connectionProblem'.tr(),
          backgroundColor: Colors.red,
        );
      }

      downloadPdf(widget.book.url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width * 0.5;
    final double height = MediaQuery.sizeOf(context).height * 0.3;
    return Scaffold(
      appBar: AppBar(title: Text(widget.category), centerTitle: false),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 40),
            discoverMoreTitle(),
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

  Padding discoverMoreTitle() {
    const categoryKey = '{category}';
    final originalTitle = 'library.discoverMore'.tr();

    final categoryIndex = originalTitle.indexOf(categoryKey);
    final titleBeforeCategory = originalTitle.substring(0, categoryIndex);
    final category =
        originalTitle.substring(categoryIndex, categoryIndex + categoryKey.length).replaceFirst(categoryKey, widget.category);
    final titleAfterCategory = originalTitle.substring(categoryIndex + categoryKey.length, originalTitle.length);

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text.rich(
        TextSpan(
          text: titleBeforeCategory,
          style: ViewUtils.ubuntuStyle(fontSize: 17),
          children: [
            TextSpan(
              text: categoryIndex == 0 ? "$category -" : "- $category",
              style: ViewUtils.ubuntuStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: titleAfterCategory,
              style: ViewUtils.ubuntuStyle(),
            )
          ],
        ),
      ),
    );
  }
}

class DynamicButton extends StatelessWidget {
  const DynamicButton({
    super.key,
    required this.onTap,
    required this.details,
  });

  final VoidCallback? onTap;
  final Details details;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.green.shade100),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        ),
        child: details.downloading
            ? Text(
                details.process.toPercent(),
                textAlign: TextAlign.center,
                style: ViewUtils.ubuntuStyle(fontSize: 18, color: Colors.black),
              )
            : SvgPicture.asset(details.cached ? Assets.svg.openBook : Assets.svg.download),
      ),
    );
  }
}

class Details {
  final Color buttonColor;
  final double process;
  final bool downloading;
  final String buttonText;
  final String path;
  final bool cached;

  Details({
    required this.buttonColor,
    required this.process,
    required this.downloading,
    required this.buttonText,
    required this.path,
    required this.cached,
  });

  factory Details.initial() {
    return Details(
      buttonColor: Colors.green,
      process: 0,
      downloading: false,
      buttonText: '',
      path: '',
      cached: false,
    );
  }

  Details copyWith({
    Color? buttonColor,
    double? process,
    bool? downloading,
    String? buttonText,
    String? path,
    bool? cached,
  }) {
    return Details(
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
}

enum ButtonText {
  downloading(''),
  download('Download'),
  open('Open');

  final String text;
  const ButtonText(this.text);
}

class BookActionButtonRow extends StatelessWidget {
  final Details details;
  final String bookUrl;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final Book book;
  final String category;

  const BookActionButtonRow({
    super.key,
    required this.details,
    required this.bookUrl,
    required this.onTap,
    required this.onDelete,
    required this.book,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: SizedBox(
            width: 100,
            child: DynamicButton(
              onTap: onTap,
              details: details,
            ),
          ),
        ),
        const SizedBox(width: 30),
        if (details.cached)
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: onDelete,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                child: SvgPicture.asset(Assets.svg.bin, color: Colors.white),
              ),
            ),
          ),
        const SizedBox(width: 30),
        BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            final isSaved = state.books?.isBookmerked(book);

            return GestureDetector(
              onTap: () {
                if (isSaved ?? false) {
                  BlocProvider.of<CategoryBloc>(context).add(
                    CategoryEvent.removeBookmarkedBook(
                      category,
                      book,
                    ),
                  );
                } else {
                  BlocProvider.of<CategoryBloc>(context).add(
                    CategoryEvent.bookmarkBookInitial(
                      category,
                      book,
                    ),
                  );
                }
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(7),
                margin: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary, width: 2),
                  color: Colors.white,
                ),
                child: SvgPicture.asset(
                  Assets.svg.bookmark,
                  height: 35,
                  width: 35,
                  color: isSaved ?? false ? Colors.orange.shade900 : Colors.blue.shade200,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

extension on List<Book> {
  bool isBookmerked(Book book) {
    return any((bb) => bb == book);
  }
}
