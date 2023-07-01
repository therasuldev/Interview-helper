import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/app_navigators.dart';
import 'package:flutter_interview_questions/core/local_service/cache_service.dart';
import 'package:flutter_interview_questions/core/model/book/book.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

//TODO yukleme qurtaranda downlaod buttonu yox olmur
class BookView extends StatefulWidget {
  const BookView({
    super.key,
    required this.book,
    required this.index,
    required this.isExist,
    required this.otherBooks,
  });

  final Book book;
  final int index;
  final bool isExist;
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

  /// when proceed the downloading prosses
  bool _isProceed = false;

  final Map<int, double> _downloadProgress = {};
  final CacheService _cacheService = CacheService();

  Future downloadFile(int index, Book book) async {
    final url = await book.url;
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/${book.name}';

    await Dio().download(
      url,
      path,
      onReceiveProgress: (count, total) {
        double progress = count / total;
        setState(() {
          _isProceed = true;
          _downloadProgress[index] = progress;
        });
      },
    ).whenComplete(() async {
      await _cacheService.downloadedBooks.put(book.name, book.name);
      setState(() => _isProceed = false);
    });
  }

  Widget? subtitleWidget() {
    if (_downloadProgress[widget.index] != null && _isProceed) {
      return LinearProgressIndicator(value: _downloadProgress[widget.index]);
    }
    if (_downloadProgress[widget.index] != null && !_isProceed) return null;
    return null;
  }

  Widget trailingWidget() {
    // sehife acilanda kantrol
    if (widget.isExist) {
      return const Icon(Icons.download_done);
    }
    // yukleme qurtarandan sonra kantrol
    else if (!_isProceed) {
      return _KCupertinoButton(
        buttonText: 'open',
        textColor: Colors.grey.shade600,
        borderColor: Colors.grey.shade500,
        //TODO: must be open file
        onPressed: () => downloadFile(widget.index, widget.book),
      );
    }
    // fayl yuklenmeyibse
    return _KCupertinoButton(
      buttonText: 'download',
      textColor: Colors.green,
      borderColor: Colors.green,
      onPressed: () => downloadFile(widget.index, widget.book),
    );
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
                  color: Colors.purple,
                  width: MediaQuery.of(context).size.width * .7,
                  height: MediaQuery.of(context).size.width * .7,
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
                trailingWidget(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .6,
                  child: ListTile(title: subtitleWidget()),
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
                            BookView(
                              book: book,
                              index: widget.index,
                              isExist: widget.isExist,
                              otherBooks: otherBooks,
                            ),
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

class _KCupertinoButton extends StatelessWidget {
  const _KCupertinoButton({
    required this.buttonText,
    required this.onPressed,
    required this.textColor,
    required this.borderColor,
  });

  final void Function()? onPressed;
  final String buttonText;
  final Color textColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * .6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: borderColor, width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          buttonText,
          style: ViewUtils.ubuntuStyle(color: textColor, fontSize: 19),
        ),
      ),
    );
  }
}
