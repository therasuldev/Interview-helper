import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_helper/gen/assets.gen.dart';

import '../../../domain/models/book/book.dart';
import '../../../domain/models/book_view_details.dart';

import '../../../utils/index.dart';
import '../../widgets/index.dart';

class AllBooksOfCategory extends StatefulWidget {
  const AllBooksOfCategory({
    super.key,
    required this.books,
    required this.category,
  });

  final List<Book> books;
  final String category;

  @override
  State<AllBooksOfCategory> createState() => _AllBooksOfCategoryState();
}

class _AllBooksOfCategoryState extends State<AllBooksOfCategory> {
  @override
  void initState() {
    super.initState();
    books = widget.books;
  }

  late List<Book> books;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width * 0.5;
    final double height = MediaQuery.sizeOf(context).height * 0.3;
    return Scaffold(
      appBar: AppBar(title: Text('library.allBooks'.tr()), centerTitle: false),
      body: GridView.builder(
        itemBuilder: (context, index) {
          final book = books[index];
          return GestureDetector(
            onTap: () {
              final otherBooks = books.where((b) => b != book).toList();

              context.goNamed(
                AppRouteConstant.bookView,
                extra: BookViewDetails(
                  book: book,
                  otherBooks: otherBooks,
                  category: widget.category,
                ),
              );
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width * .6,
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Hero(
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
                                scale: .2,
                                child: SvgPicture.asset(Assets.svg.connectionLost),
                              );
                            },
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),

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
        addAutomaticKeepAlives: true,
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
