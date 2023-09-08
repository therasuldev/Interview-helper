import 'package:flutter/material.dart';
import 'package:interview_prep/core/model/book/book.dart';
import 'package:interview_prep/pdf_view_model.dart';

class OpenPDF extends StatelessWidget {
  const OpenPDF({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) => Scaffold(
      body: BookViewModel(book: book).buildBookforEntireScreen(context));
}
