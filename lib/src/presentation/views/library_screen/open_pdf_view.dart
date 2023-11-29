import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../widgets/widgets.dart';

class OpenPDFView extends StatelessWidget {
  const OpenPDFView({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BookViewModel(book: book).buildBookforEntireScreen(context),
    );
  }
}
