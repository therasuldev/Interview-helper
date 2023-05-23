import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/view/utils/utils.dart';

class BookStore extends StatefulWidget {
  const BookStore({super.key});

  @override
  State<BookStore> createState() => _BookStoreState();
}

class _BookStoreState extends State<BookStore> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        _RowTitleWidget(title: 'Flutter'),
        _BookCardWidget(),
        //*
        _RowTitleWidget(title: 'Go Lang'),
        _BookCardWidget(),
      ],
    );
  }
}

class _BookCardWidget extends StatelessWidget {
  const _BookCardWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 15, bottom: 7, top: 7),
            width: 180,
            decoration: ViewUtils.categoryCard(),
          );
        },
      ),
    );
  }
}

class _RowTitleWidget extends StatelessWidget {
  const _RowTitleWidget({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: ViewUtils.ubuntuStyle(fontSize: 20)),
        TextButton(
          onPressed: () {},
          child: Text('All', style: ViewUtils.ubuntuStyle(fontSize: 20)),
        )
      ],
    );
  }
}
