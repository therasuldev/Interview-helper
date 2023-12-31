import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:interview_helper/gen/assets.gen.dart';
import 'package:interview_helper/src/utils/extensions/to_percent.dart';

import '../../domain/models/index.dart';
import 'index.dart';

abstract class IBookViewModel {
  Widget bigSizeBookView(BuildContext context);
  Widget smallSizeBookView(BuildContext context);
}

class BookViewModel extends IBookViewModel {
  final Book book;

  BookViewModel({required this.book});
  @override
  Widget bigSizeBookView(BuildContext context) {
    return _PDFViewModel(
      book: book,
      width: MediaQuery.of(context).size.height,
      height: MediaQuery.of(context).size.height,
    );
  }

  @override
  Widget smallSizeBookView(BuildContext context) {
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
    final child = CachedNetworkImage(
      imageUrl: book.imageUrl,
      progressIndicatorBuilder: (context, url, progress) {
        return KShimmer(progress: (progress.progress ?? 0).toPercent());
      },
      errorWidget: (context, url, error) {
        return Transform.scale(
          scale: .2,
          child: SvgPicture.asset(Assets.svg.connectionLost),
        );
      },
    );
    return Hero(tag: book.name, child: SizedBox(height: height, width: width, child: child));
  }
}
