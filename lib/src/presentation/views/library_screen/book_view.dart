import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../utils/decorations/view_utils.dart';
import '../../widgets/widgets.dart';
import 'library.dart';


class BookView extends StatefulWidget {
  const BookView({
    super.key,
    required this.book,
    required this.index,
    required this.otherBooks,
  });

  final Book book;
  final int index;
  final List<Book> otherBooks;

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  @override
  void initState() {
    super.initState();
    allBooks = [...widget.otherBooks, widget.book];
  }

  late List<Book> allBooks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BookViewModel(book: widget.book).buildBookforViewScreen(context),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  builder(_) => OpenPDFView(book: widget.book);
                  final destination = MaterialPageRoute(builder: builder);
                  await Navigator.push(context, destination);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.book.name,
                    textAlign: TextAlign.center,
                    style: ViewUtils.ubuntuStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              BooksView(allBooks: allBooks, otherBooks: widget.otherBooks)
            ],
          ),
        ),
      ),
    );
  }
}
