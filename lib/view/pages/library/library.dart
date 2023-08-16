import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_questions/app_navigators.dart';
import 'package:flutter_interview_questions/core/repository/cache_repository.dart';
import 'package:flutter_interview_questions/get_book_from_cache.dart';
import 'package:flutter_interview_questions/spinkit_circle_loading_widget.dart';
import 'package:flutter_interview_questions/view/pages/library/all_items/all_books.dart';
import 'package:flutter_interview_questions/view/pages/library/book_view.dart';

import 'package:flutter_interview_questions/core/model/book/book.dart';
import 'package:flutter_interview_questions/core/provider/books_bloc/books_bloc.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';

import '../../../core/app/enum/lang_title_enum.dart';
import '../../../core/app/enum/lang_type_enum.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        if (state.loading!) {
          return const Center(child: KSpinKitCircle());
        } else if (!state.loading!) {
          return ListView(
            shrinkWrap: true,
            children: [
              //* Flutter
              _RowTitleWidget(
                title: Titles.flutter.title,
                page: AllBooks(books: state.library![0][Type.flutter.type]!),
              ),
              _BookCardWidget(books: state.library![0][Type.flutter.type]!),

              //* Go
              _RowTitleWidget(
                title: Titles.go.title,
                page: AllBooks(books: state.library![1][Type.go.type]!),
              ),
              _BookCardWidget(books: state.library![1][Type.go.type]!),

              //* Java
              _RowTitleWidget(
                title: Titles.java.title,
                page: AllBooks(books: state.library![2][Type.java.type]!),
              ),
              _BookCardWidget(books: state.library![2][Type.java.type]!),

              //* Python
              _RowTitleWidget(
                title: Titles.python.title,
                page: AllBooks(books: state.library![3][Type.python.type]!),
              ),
              _BookCardWidget(books: state.library![3][Type.python.type]!),

              //* Ruby
              _RowTitleWidget(
                title: Titles.ruby.title,
                page: AllBooks(books: state.library![4][Type.ruby.type]!),
              ),
              _BookCardWidget(books: state.library![4][Type.ruby.type]!),

              //* Kotlin
              _RowTitleWidget(
                title: Titles.kotlin.title,
                page: AllBooks(books: state.library![5][Type.kotlin.type]!),
              ),
              _BookCardWidget(books: state.library![5][Type.kotlin.type]!),

              //* Type Script
              _RowTitleWidget(
                title: Titles.typescript.title,
                page: AllBooks(books: state.library![6][Type.typescript.type]!),
              ),
              _BookCardWidget(books: state.library![6][Type.typescript.type]!),

              //* Rust
              _RowTitleWidget(
                title: Titles.rust.title,
                page: AllBooks(books: state.library![7][Type.rust.type]!),
              ),
              _BookCardWidget(books: state.library![7][Type.rust.type]!),

              //* Java Script
              _RowTitleWidget(
                title: Titles.js.title,
                page: AllBooks(books: state.library![8][Type.js.type]!),
              ),
              _BookCardWidget(books: state.library![8][Type.js.type]!),

              //* React
              _RowTitleWidget(
                title: Titles.react.title,
                page: AllBooks(books: state.library![9][Type.react.type]!),
              ),
              _BookCardWidget(books: state.library![9][Type.react.type]!),

              //* C#
              _RowTitleWidget(
                title: Titles.csharp.title,
                page: AllBooks(books: state.library![10][Type.csharp.type]!),
              ),
              _BookCardWidget(books: state.library![10][Type.csharp.type]!),

              //* NodeJS
              _RowTitleWidget(
                title: Titles.nodejs.title,
                page: AllBooks(books: state.library![11][Type.nodejs.type]!),
              ),
              _BookCardWidget(books: state.library![11][Type.nodejs.type]!),

              //* Perl
              _RowTitleWidget(
                title: Titles.perl.title,
                page: AllBooks(books: state.library![12][Type.perl.type]!),
              ),
              _BookCardWidget(books: state.library![12][Type.perl.type]!),

              //* PHP
              _RowTitleWidget(
                title: Titles.php.title,
                page: AllBooks(books: state.library![13][Type.php.type]!),
              ),
              _BookCardWidget(books: state.library![13][Type.php.type]!),

              //* Scala
              _RowTitleWidget(
                title: Titles.scala.title,
                page: AllBooks(books: state.library![14][Type.scala.type]!),
              ),
              _BookCardWidget(books: state.library![14][Type.scala.type]!),

              //* Swift
              _RowTitleWidget(
                title: Titles.swift.title,
                page: AllBooks(books: state.library![15][Type.swift.type]!),
              ),
              _BookCardWidget(books: state.library![15][Type.swift.type]!),

              //* C++
              _RowTitleWidget(
                title: Titles.cplusplus.title,
                page: AllBooks(books: state.library![16][Type.cplusplus.type]!),
              ),
              _BookCardWidget(books: state.library![16][Type.cplusplus.type]!),

              //* Git
              _RowTitleWidget(
                title: Titles.git.title,
                page: AllBooks(books: state.library![17][Type.git.type]!),
              ),
              _BookCardWidget(books: state.library![17][Type.git.type]!),

              //* Cyber Security
              _RowTitleWidget(
                title: Titles.cybersecurity.title,
                page: AllBooks(
                    books: state.library![18][Type.cybersecurity.type]!),
              ),
              _BookCardWidget(
                  books: state.library![18][Type.cybersecurity.type]!),
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
            child: _BookCard(book: book),
            onTap: () {
              final otherBooks = books.where((currentBook) {
                return currentBook != book;
              }).toList();
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
  const _BookCard({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          GetBooksFromCache(book: book),
          const SizedBox(height: 15),
          Expanded(
            child: Text(
              book.name,
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
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => page),
              (route) => true,
            );
          },
          child: Text('All', style: ViewUtils.ubuntuStyle(fontSize: 20)),
        )
      ],
    );
  }
}
