import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/app_navigators.dart';
import 'package:flutter_interview_questions/core/model/book/book.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';

class BookView extends StatefulWidget {
  const BookView({
    super.key,
    required this.book,
    required this.otherBooks,
  });

  final Book book;
  final List<Book> otherBooks;
  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  late List<Book> allBooks;
  @override
  void initState() {
    super.initState();
    allBooks = [...widget.otherBooks, widget.book];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * .7,
                  width: MediaQuery.of(context).size.width * .7,
                  color: Colors.purple,
                  child: const Placeholder(),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.book.name,
                    textAlign: TextAlign.center,
                    style: ViewUtils.ubuntuStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * .6,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    child: Text('download', style: ViewUtils.ubuntuStyle()),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: MediaQuery.of(context).size.width * .8,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.otherBooks.length,
                    itemBuilder: (context, index) {
                      final book = widget.otherBooks[index];
                      return GestureDetector(
                        onTap: () {
                          final otherBooks =
                              allBooks.where((b) => b != book).toList();
                          AppNavigators.go(
                            context,
                            BookView(book: book, otherBooks: otherBooks),
                          );
                        },
                        child: Container(
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
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  child: Text(
                                    book.name,
                                    textAlign: TextAlign.center,
                                    style: ViewUtils.ubuntuStyle(fontSize: 19),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
