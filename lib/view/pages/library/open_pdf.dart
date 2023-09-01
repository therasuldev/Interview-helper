import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/core/model/book/book.dart';
import 'package:flutter_interview_questions/pdf_view_model.dart';

class OpenPDF extends StatelessWidget {
  const OpenPDF({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) => Scaffold(
      body: BookViewModel(book: book).buildBookforEntireScreen(context));
}
