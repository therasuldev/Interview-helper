import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/app_navigators.dart';
import 'package:flutter_interview_questions/core/cache/cache_service.dart';
import 'package:flutter_interview_questions/core/model/book/book.dart';
import 'package:flutter_interview_questions/gen/assets.gen.dart';
import 'package:flutter_interview_questions/view/pages/library/book_view.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';

class AllBooks extends StatefulWidget {
  const AllBooks({super.key, required this.books});
  final List<Book> books;

  @override
  State<AllBooks> createState() => _AllBooksState();
}

class _AllBooksState extends State<AllBooks> {
  //TODO
  final CacheService _cacheService = CacheService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          childAspectRatio: 12 / 13,
        ),
        itemCount: widget.books.length,
        itemBuilder: (context, index) {
          final book = widget.books[index];
          final existBookName = _cacheService.downloadedBooks.get(book.name);
          final isExist = book.name == existBookName;
          return GestureDetector(
            onTap: () {
              //TODO
              final otherBooks = widget.books.where((b) => b != book).toList();
              AppNavigators.go(
                context,
                BookView(
                  book: book,
                  index: index,
                  isExist: isExist,
                  otherBooks: otherBooks,
                ),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    child: Image.asset(Assets.logo.logoFlutter.path),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.width * .18,
                      width: MediaQuery.of(context).size.width * .7,
                      alignment: Alignment.center,
                      child: Text(
                        book.name,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: ViewUtils.ubuntuStyle(fontSize: 19),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
