import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_interview_questions/core/model/book/book.dart';
import 'package:flutter_interview_questions/spinkit_circle_loading_widget.dart';

class GetBooksFromCache extends StatelessWidget {
  const GetBooksFromCache({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: book.url,
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: MediaQuery.of(context).size.width * .5,
            child: const PDF(swipeHorizontal: true).cachedFromUrl(
              snapshot.data!,
              placeholder: (progress) {
                return Center(child: Text('${progress.toInt()} %'));
              },
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const KSpinKitCircle();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}