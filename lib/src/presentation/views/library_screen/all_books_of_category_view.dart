import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_prep/src/config/router/app_route_const.dart';
import 'package:interview_prep/src/presentation/widgets/pdf_view_model.dart';
import 'package:interview_prep/src/domain/models/book/book.dart';
import 'package:interview_prep/src/utils/decorations/view_utils.dart';

class AllBooksOfCategory extends StatelessWidget {
  const AllBooksOfCategory({super.key, required this.books});

  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemBuilder: (context, index) {
          final book = books[index];
          return GestureDetector(
            onTap: () {
              final otherBooks = books.where((b) => b != book).toList();

              context.goNamed(
                AppRouteConstant.bookView,
                extra: BookViewDetails(index: index, book: book, otherBooks: otherBooks),
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
        itemCount: books.length,
        addRepaintBoundaries: false,
        addAutomaticKeepAlives: false,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 5 / 9,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
      ),
    );
  }
}
