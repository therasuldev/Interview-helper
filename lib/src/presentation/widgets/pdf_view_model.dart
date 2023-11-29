import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../../domain/models/models.dart';
import 'widgets.dart';

abstract class IBookViewModel {
  Widget buildBookforEntireScreen(BuildContext context);
  Widget buildBookforViewScreen(BuildContext context);
}

class BookViewModel extends IBookViewModel {
  final Book book;

  BookViewModel({required this.book});
  @override
  Widget buildBookforEntireScreen(BuildContext context) {
    return _PDFViewModel(
      book: book,
      width: MediaQuery.of(context).size.height,
      height: MediaQuery.of(context).size.height,
    );
  }

  @override
  Widget buildBookforViewScreen(BuildContext context) {
    return _PDFViewModel(
      book: book,
      width: MediaQuery.of(context).size.width * .5,
      height: MediaQuery.of(context).size.height * .3,
    );
  }
}

class _PDFViewModel extends StatelessWidget {
  const _PDFViewModel({
    required this.book,
    required this.height,
    required this.width,
  });

  final Book book;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final child = const PDF().cachedFromUrl(
      book.url,
      key: ValueKey(book.name),
      placeholder: (p) => KShimmer(progress: '${p.toInt()} %'),
    );
    return SizedBox(height: height, width: width, child: child);
  }
}
