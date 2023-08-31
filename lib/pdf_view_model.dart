import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'package:flutter_interview_questions/core/model/book/book.dart';
import 'package:flutter_interview_questions/shimmer_loading.dart';
import 'package:flutter_interview_questions/spinkit_circle_loading_widget.dart';

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
    return FutureBuilder<String>(
      future: book.url,
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          final child = const PDF().cachedFromUrl(
            snapshot.data!,
            placeholder: (p) => KShimmer(progress: '${p.toInt()} %'),
          );
          return SizedBox(height: height, width: width, child: child);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const KSpinKitCircle();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
