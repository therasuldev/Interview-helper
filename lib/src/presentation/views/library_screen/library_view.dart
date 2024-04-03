import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_helper/src/domain/models/index.dart';
import 'package:interview_helper/src/presentation/provider/bloc/books/books_bloc.dart';
import 'package:interview_helper/src/presentation/provider/bloc/category/category_bloc.dart';
import 'package:interview_helper/src/utils/index.dart';
import '../../widgets/index.dart';
import 'index.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryBloc>(context).add(CategoryEvent.fetchBookmarkedBooksStart());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        if (state.loading!) {
          return const Center(child: KSpinKitCircle());
        } else if (!state.loading!) {
          return ListView(children: buildLanguageColumn(state));
        }
        return Center(child: Text(state.error.toString()));
      },
    );
  }

  List<Widget> buildLanguageColumn(BookState state) {
    List<Widget> column = [];
    for (var i = 0; i < state.library!.length; i++) {
      final categoryTitle = CategoryTitles.libraryCategory[i];
      final category = state.library![i].keys.first;

      column.addAll([
        _RowTitleWidget(
          title: categoryTitle,
          books: state.library![i][category]!,
        ),
        CategoryCollection(
          category: categoryTitle,
          otherBooks: state.library![i][category]!,
        ),
      ]);
    }
    return column;
  }
}

class _RowTitleWidget extends StatelessWidget {
  const _RowTitleWidget({
    required this.books,
    required this.title,
  });

  final List<Book> books;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: ViewUtils.ubuntuStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
          TextButton(
            onPressed: () {
              context.goNamed(
                AppRouteConstant.allBooks,
                extra: books,
                queryParameters: {'category': title},
              );
            },
            child: Text(
              'library.all'.tr(),
              style: ViewUtils.ubuntuStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }
}
