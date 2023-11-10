import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:interview_prep/src/presentation/widgets/pdf_view_model.dart';
import 'package:interview_prep/src/config/router/app_navigators.dart';
import 'package:interview_prep/src/domain/models/book/book.dart';
import 'package:interview_prep/src/presentation/views/library_screen/book_view.dart';
import 'package:interview_prep/src/utils/decorations/view_utils.dart';

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
            otherBooks1 = otherBooks.where((currentBook) {
              return currentBook != book;
            }).toList();
          } else {
            otherBooks1 = allBooks!.where((b) => b != book).toList();
          }
          return GestureDetector(
            onTap: () {
              AppNavigators.go(
                context,
                BookView(
                  book: book,
                  index: index,
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
