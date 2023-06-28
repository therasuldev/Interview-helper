import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/app_navigators.dart';
import 'package:flutter_interview_questions/core/model/book/book.dart';
import 'package:flutter_interview_questions/view/pages/library/book_view.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';

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
          childAspectRatio: 3 / 5,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
        itemCount: widget.books.length,
        itemBuilder: (context, index) {
          final book = widget.books[index];
          return GestureDetector(
            onTap: () {
              final otherBooks = widget.books.where((b) => b!=book).toList();
              AppNavigators.go(context, BookView(book: book, otherBooks: otherBooks));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * .7,
              color: Colors.green,
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * .5,
                    color: Colors.yellow,
                    child: const Placeholder(),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Text(
                        book.name,
                        textAlign: TextAlign.center,
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
