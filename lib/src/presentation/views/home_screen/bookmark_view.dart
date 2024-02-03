import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_helper/src/data/datasources/remote/books_source_data_source.dart';
import 'package:interview_helper/src/domain/models/index.dart';
import 'package:interview_helper/src/presentation/provider/bloc/category/category_bloc.dart';
import 'package:interview_helper/src/presentation/widgets/index.dart';
import 'package:interview_helper/src/utils/index.dart';

class BookmarkedDatas extends StatefulWidget {
  const BookmarkedDatas({super.key});

  @override
  State<BookmarkedDatas> createState() => _BookmarkedDatasState();
}

class _BookmarkedDatasState extends State<BookmarkedDatas> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    booksSourceDataImpl = BooksSourceDataImpl();

    context.read<CategoryBloc>().add(CategoryEvent.fetchBookmarkedQuestionsStart());
    controller.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (controller.indexIsChanging) return;

    if (controller.index == 0) {
      context.read<CategoryBloc>().add(CategoryEvent.fetchBookmarkedQuestionsStart());
    } else {
      context.read<CategoryBloc>().add(CategoryEvent.fetchBookmarkedBooksStart());
    }
  }

  @override
  void dispose() {
    controller.removeListener(_handleTabSelection);
    controller.dispose();
    super.dispose();
  }

  late TabController controller;
  late final BooksSourceDataImpl booksSourceDataImpl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Questions'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: TabBar(
            controller: controller,
            tabs: const [Tab(text: 'Questions'), Tab(text: 'Books')],
          ),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state.loading!) {
                return const Center(child: CircularProgressIndicator());
              }
              final qCategories = state.questionCategories;
              if (qCategories!.isEmpty) {
                return const Center(
                  child: Text('No Saved Categories'),
                );
              }
              return ListView.builder(
                itemCount: qCategories.length,
                itemBuilder: (context, index) {
                  final qCategory = qCategories[index];
                  return ExpansionTile(
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          qCategory.name,
                          style: ViewUtils.ubuntuStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    children: qCategory.questions!.map((q) {
                      return ListTile(
                        title: Text(q.question, style: ViewUtils.ubuntuStyle(fontSize: 20, color: Colors.black)),
                        subtitle: Text(
                          q.answer,
                          style: ViewUtils.ubuntuStyle(
                            fontSize: 18,
                            color: Colors.blueGrey.withOpacity(.6).withBlue(155),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              );
            },
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state.loading!) {
                return const CircularProgressIndicator();
              }
              final bCategories = state.bookCategories;
              if (bCategories!.isEmpty) {
                return const Center(
                  child: Text('No Saved Categories'),
                );
              }
              return ListView.builder(
                itemCount: bCategories.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final bCategory = bCategories[index];
                  return ExpansionTile(
                    title: Text(bCategory.name),
                    children: [
                      SizedBox(
                        height: 250, // Yatay listelenen kitapların yüksekliği. İhtiyaca göre ayarlayın.
                        child: ListView.builder(
                          itemCount: bCategory.books!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final book = bCategory.books![index];
                            return GestureDetector(
                              onTap: () async {
                                List<Book> books = [];

                                final data = await booksSourceDataImpl.getBooksByCategory(bCategory.name);
                                for (var bookJson in data) {
                                  books.add(Book.fromJson(bookJson));
                                }

                                final otherBooks = books.getOtherBooks(book);
                                if (!context.mounted) return;

                                context.goNamed(
                                  AppRouteConstant.bookView,
                                  extra: BookViewDetails(
                                    index: index,
                                    book: book,
                                    category: bCategory.name,
                                    otherBooks: otherBooks,
                                  ),
                                );
                              },
                              child: SmallSizeBookView(book: book, category: bCategory.name),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

extension on List<Book> {
  List<Book> getOtherBooks(Book book) {
    return where((currentBook) {
      return currentBook != book;
    }).toList();
  }
}
