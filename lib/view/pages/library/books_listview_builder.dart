import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/app_navigators.dart';
import 'package:flutter_interview_questions/core/model/book/book.dart';
import 'package:flutter_interview_questions/get_book_from_cache.dart';
import 'package:flutter_interview_questions/view/pages/library/book_view.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';

class BooksListViewBuilder extends StatelessWidget {
  const BooksListViewBuilder({
    super.key,
    this.allBooks,
    required this.otherBooks,
  });

  final List<Book>? allBooks;
  final List<Book> otherBooks;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .4,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        //TODO phisyc
        itemCount: otherBooks.length,
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
              width: MediaQuery.of(context).size.width * .6,
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [
                  GetBooksFromCache(book: book),
                  const SizedBox(height: 15),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Text(
                        book.name,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: ViewUtils.ubuntuStyle(fontSize: 19,fontWeight: FontWeight.w300),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
