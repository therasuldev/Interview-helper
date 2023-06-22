import 'package:flutter/material.dart';

class AllBooks extends StatefulWidget {
  const AllBooks({super.key});

  @override
  State<AllBooks> createState() => _AllBooksState();
}

class _AllBooksState extends State<AllBooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 200),
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            width: 100,
            color: Colors.red,
          );
        },
      ),
    );
  }
}
