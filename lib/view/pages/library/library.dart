import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/app_navigators.dart';
import 'package:flutter_interview_questions/gen/assets.gen.dart';
import 'package:flutter_interview_questions/view/pages/library/book_view.dart';
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
      shrinkWrap: true,
      children: [
        _RowTitleWidget(title: 'Flutter', onPressed: () {}),
        const _BookCardWidget(),
        //*
        _RowTitleWidget(title: 'Go Lang', onPressed: () {}),
        const _BookCardWidget(),
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
          return Semantics(
            button: true,
            child: InkWell(
              onTap: () {
                AppNavigators.go(context, const BookView());
              },
              child: Container(
                margin: const EdgeInsets.only(right: 15, bottom: 7, top: 7),
                width: 180,
                decoration: ViewUtils.categoryCard(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                      width: 100,
                      child: Image.asset(
                        Assets.programmingLangPng.java.path,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Java book',
                          style: ViewUtils.ubuntuStyle(fontSize: 17),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.download),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RowTitleWidget extends StatelessWidget {
  const _RowTitleWidget({required this.title, required this.onPressed});

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: ViewUtils.ubuntuStyle(fontSize: 20)),
        TextButton(
          onPressed: onPressed,
          child: Text('All', style: ViewUtils.ubuntuStyle(fontSize: 20)),
        )
      ],
    );
  }
}
