import 'package:flutter/material.dart';
import 'package:interview_prep/app_navigators.dart';
import 'package:interview_prep/core/model/book/book.dart';
import 'package:interview_prep/pdf_view_model.dart';
import 'package:interview_prep/view/pages/library/book_view.dart';
import 'package:interview_prep/view/utils/utils.dart';

class AllBooks extends StatefulWidget {
  const AllBooks({super.key, required this.books});
  final List<Book> books;

  @override
  State<AllBooks> createState() => _AllBooksState();
}

class _AllBooksState extends State<AllBooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 5 / 9,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
        itemCount: widget.books.length,
        itemBuilder: (context, index) {
          final book = widget.books[index];
          return GestureDetector(
            onTap: () {
              final otherBooks = widget.books.where((b) => b != book).toList();
              AppNavigators.go(
                context,
                BookView(
                  book: book,
                  index: index,
                  otherBooks: otherBooks,
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width * .6,
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [
                  BookViewModel(book: book).buildBookforViewScreen(context),
                  const SizedBox(height: 15),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Text(
                        book.name,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: ViewUtils.ubuntuStyle(fontSize: 19),
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
