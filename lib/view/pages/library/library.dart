import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_questions/core/utils/screen_data_paths.dart';
import 'package:flutter_interview_questions/spinkit_circle_loading_widget.dart';
import 'package:flutter_interview_questions/view/pages/library/all_items/all_books.dart';
import 'package:flutter_interview_questions/core/provider/books_bloc/books_bloc.dart';
import 'package:flutter_interview_questions/view/pages/library/books_listview_builder.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';
import '../../../core/app/enum/titles.dart';

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
            children: buildLanguageRows(state),
          );
        } else {
          return Center(child: Text(state.error.toString()));
        }
      },
    );
  }

  List<Widget> buildLanguageRows(BookState state) {
    List<Widget> rows = [];
    for (var i = 0;
        i < ScreenDataPaths().libraryCategoryPathNames.length;
        i++) {
      var type = ScreenDataPaths().libraryCategoryPathNames[i];
      var title = Titles.values[i];
      rows.addAll([
        _RowTitleWidget(
          title: title.title,
          page: AllBooks(books: state.library![i][type]!),
        ),
        BooksListViewBuilder(otherBooks: state.library![i][type]!),
      ]);
    }
    return rows;
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: ViewUtils.ubuntuStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
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
      ),
    );
  }
}
