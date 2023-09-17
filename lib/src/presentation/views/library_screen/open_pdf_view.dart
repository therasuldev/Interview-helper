import 'package:flutter/material.dart';
import 'package:interview_prep/src/presentation/widgets/pdf_view_model.dart';
import 'package:interview_prep/src/domain/models/book/book.dart';

class OpenPDFView extends StatelessWidget {
  const OpenPDFView({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) => Scaffold(
      body: BookViewModel(book: book).buildBookforEntireScreen(context));
}
