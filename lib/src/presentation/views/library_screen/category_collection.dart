import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_helper/gen/assets.gen.dart';

import '../../../domain/models/index.dart';
import '../../../utils/index.dart';
import '../../widgets/index.dart';

class CategoryCollection extends StatelessWidget {
  const CategoryCollection({
    super.key,
    this.allBooks,
    required this.category,
    required this.otherBooks,
  });

  final List<Book>? allBooks;
  final List<Book> otherBooks;
  final String category;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width * 0.5;
    final double height = MediaQuery.sizeOf(context).height * 0.3;
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .4,
      child: ListView.builder(
        itemBuilder: (context, index) {
          final book = otherBooks[index];
          List<Book> otherBooks1 = [];

          otherBooks1 = allBooks == null ? otherBooks.getOtherBooks(book) : allBooks!.where((bk) => bk != book).toList();
          return GestureDetector(
            onTap: () {
              context.goNamed(
                AppRouteConstant.bookView,
                extra: BookViewDetails(
                  book: book,
                  category: category,
                  otherBooks: otherBooks1,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              width: MediaQuery.sizeOf(context).width * .6,
              child: Column(
                children: [
                  Hero(
                    tag: book.name,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          height: height,
                          width: width,
                          child: CachedNetworkImage(
                            imageUrl: book.imageUrl,
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
                  const SizedBox(height: 15),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: AutoSizeText(
                        book.name,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: ViewUtils.ubuntuStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 19,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        addRepaintBoundaries: false,
        itemCount: otherBooks.length,
        addAutomaticKeepAlives: false,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}

extension on List<Book> {
  List<Book> getOtherBooks(Book book) {
    return where((currentBook) {
      return currentBook != book;
    }).toList();
  }
}
