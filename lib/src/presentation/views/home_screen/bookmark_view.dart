import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_helper/gen/assets.gen.dart';
import 'package:interview_helper/src/data/datasources/remote/books_source_data_source.dart';
import 'package:interview_helper/src/domain/models/index.dart';
import 'package:interview_helper/src/presentation/provider/bloc/category/category_bloc.dart';
import 'package:interview_helper/src/presentation/widgets/index.dart';
import 'package:interview_helper/src/presentation/widgets/question_card.dart';
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
    setState(() {});
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
    final width = MediaQuery.sizeOf(context).width * 0.5;
    final height = MediaQuery.sizeOf(context).height * 0.3;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'home.bookmarks'.tr(),
          style: ViewUtils.ubuntuStyle(fontSize: 19),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: TabBar(
            controller: controller,
            indicatorColor: Colors.blue.shade900,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              DefaultTextStyle(
                style: const TextStyle().isActive(controller.index == 0),
                child: Text('home.questions'.tr()),
              ),
              DefaultTextStyle(
                style: const TextStyle().isActive(controller.index == 1),
                child: Text('home.books'.tr()),
              ),
            ],
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
                  //TODO translate
                  child: Text('No Saved Questions'),
                );
              }
              return ListView.builder(
                itemCount: qCategories.length,
                itemBuilder: (context, index) {
                  final qCategory = qCategories[index];
                  if (qCategory.questions!.isEmpty) return const SizedBox.shrink();
                  return ExpansionTile(
                    title: Text(
                      qCategory.name!,
                      style: ViewUtils.ubuntuStyle(fontSize: 20, color: Colors.black),
                    ),
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: qCategory.questions!.length,
                        itemBuilder: (context, qIndex) {
                          return QuestionCard(
                            questions: qCategory.questions!,
                            category: qCategory.name!,
                            fromBookmarkPage: true,
                            index: qIndex,
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state.loading!) {
                return const Center(child: CircularProgressIndicator());
              }
              final bCategories = state.bookCategories;
              if (bCategories!.isEmpty) {
                return const Center(
                  child: Text('No Saved Books'),
                );
              }
              return ListView.builder(
                itemCount: bCategories.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final bCategory = bCategories[index];
                  if (bCategory.books!.isEmpty) return const SizedBox.shrink();

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0, left: 5.0),
                          child: Text(
                            bCategory.name,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...bCategory.books!.map((book) {
                                return GestureDetector(
                                  onTap: () {
                                    context.goNamed(
                                      AppRouteConstant.bookmarkedBookView,
                                      extra: BookViewDetails(
                                        book: book,
                                        category: bCategory.name,
                                        otherBooks: [],
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Hero(
                                      tag: book.name,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          SizedBox(
                                            height: height,
                                            width: width,
                                            child: CachedNetworkImage(
                                              imageUrl: book.imageUrl,
                                              progressIndicatorBuilder: (context, url, progress) {
                                                return const KShimmer();
                                              },
                                              errorWidget: (context, url, error) {
                                                return Transform.scale(
                                                  scale: .15,
                                                  child: SvgPicture.asset(Assets.svg.connectionLost),
                                                );
                                              },
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                            ],
                          ),
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

extension on TextStyle {
  isActive(bool isActive) {
    switch (isActive) {
      case true:
        return const TextStyle(
          color: Colors.white,
          fontSize: 16,
        );

      default:
        return const TextStyle(
          color: Colors.white70,
          fontSize: 14,
        );
    }
  }
}
