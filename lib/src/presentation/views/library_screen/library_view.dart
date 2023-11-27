import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_for_interview/src/presentation/provider/bloc/books/books_bloc.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/decorations/view_utils.dart';
import '../../../utils/enum/enums.dart';
import '../../widgets/widgets.dart';
import 'library.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        if (state.loading!) {
          return const Center(child: KSpinKitCircle());
        } else if (!state.loading!) {
          return ListView(children: buildLanguageRows(state));
        } else {
          return Center(child: Text(state.error.toString()));
        }
      },
    );
  }

  List<Widget> buildLanguageRows(BookState state) {
    List<Widget> rows = [];
    for (var i = 0; i < ScreenDataPaths().libraryCategoryPathNames.length; i++) {
      final type = ScreenDataPaths().libraryCategoryPathNames[i];
      final category = Titles.values[i];
      rows.addAll([
        _RowTitleWidget(
          title: category.title,
          page: AllBooksOfCategory(books: state.library![i][type]!),
        ),
        BooksView(otherBooks: state.library![i][type]!),
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
              fontWeight: FontWeight.w800,
              fontSize: 20,
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
