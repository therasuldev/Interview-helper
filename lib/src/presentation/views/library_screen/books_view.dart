import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_for_interview/src/config/router/app_route_const.dart';

import '../../../domain/models/book/book_view_details.dart';
import '../../../domain/models/models.dart';
import '../../widgets/pdf_view_model.dart';
import '../../../utils/decorations/view_utils.dart';

class BooksView extends StatelessWidget {
  const BooksView({super.key, this.allBooks, required this.otherBooks});

  final List<Book>? allBooks;
  final List<Book> otherBooks;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .4,
      child: ListView.builder(
        itemBuilder: (context, index) {
          final book = otherBooks[index];
          List<Book> otherBooks1 = [];
          if (allBooks == null) {
            otherBooks1 = otherBooks.getOtherBooks(book);
          } else {
            otherBooks1 = allBooks!.where((bk) => bk != book).toList();
          }
          return GestureDetector(
            onTap: () {
              context.goNamed(
                AppRouteConstant.bookView,
                extra: BookViewDetails(
                  index: index,
                  book: book,
                  otherBooks: otherBooks1,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width * .6,
              child: Column(
                children: [
                  BookViewModel(book: book).buildBookforViewScreen(context),
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
                          fontSize: 19,
                          fontWeight: FontWeight.w300,
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
