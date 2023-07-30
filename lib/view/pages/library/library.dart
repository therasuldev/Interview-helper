import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_questions/app_navigators.dart';
import 'package:flutter_interview_questions/core/repository/cache_repository.dart';
import 'package:flutter_interview_questions/view/pages/library/all_items/all_books.dart';
import 'package:flutter_interview_questions/view/pages/library/book_view.dart';

import 'package:flutter_interview_questions/core/model/book/book.dart';
import 'package:flutter_interview_questions/core/provider/books_bloc/books_bloc.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';

import '../../../core/app/enum/lang_title_enum.dart';
import '../../../core/app/enum/lang_type_enum.dart';

class BookStore extends StatefulWidget {
  const BookStore({super.key});

  @override
  State<BookStore> createState() => _BookStoreState();
}

class _BookStoreState extends State<BookStore> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        if (state.loading!) {
          return const CircularProgressIndicator();
        } else if (!state.loading!) {
          return ListView(
            shrinkWrap: true,
            children: [
              //* Flutter
              _RowTitleWidget(
                title: Titles.flutter.title,
                page: AllBooks(books: state.library![0][Types.flutter.type]!),
              ),
              _BookCardWidget(books: state.library![0][Types.flutter.type]!),

              //* Go
              _RowTitleWidget(
                title: Titles.go.title,
                page: AllBooks(books: state.library![1][Types.go.type]!),
              ),
              _BookCardWidget(books: state.library![1][Types.go.type]!)
            ],
          );
        } else {
          return Center(child: Text(state.error.toString()));
        }
      },
    );
  }
}

class _BookCardWidget extends StatelessWidget {
  _BookCardWidget({required this.books}) : _cacheRepository = CacheRepository();

  final List<Book> books;

  late final CacheRepository _cacheRepository;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .35,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: books.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final book = books[index];
          final existBookName = _cacheRepository.get(book.name);
          final isExist = book.name == existBookName;

          return GestureDetector(
            child: _BookCard(bookName: book.name),
            onTap: () {
              final otherBooks = books.where((b) => b != book).toList();
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
          );
        },
      ),
    );
  }
}

class _BookCard extends StatelessWidget {
  const _BookCard({
    required String bookName,
  }) : _bookName = bookName;

  final String _bookName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      color: Colors.pink,
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
            child: Text(
              _bookName,
              textAlign: TextAlign.center,
              style: ViewUtils.ubuntuStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}

class _RowTitleWidget extends StatelessWidget {
  const _RowTitleWidget({
    required this.page,
    required this.title,
  });

  final Widget page;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: ViewUtils.ubuntuStyle(fontSize: 20)),
        TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) => page), (route) => true);
          },
          child: Text('All', style: ViewUtils.ubuntuStyle(fontSize: 20)),
        )
      ],
    );
  }
}
