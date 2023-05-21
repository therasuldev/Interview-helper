import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';

class BookStore extends StatefulWidget {
  const BookStore({super.key});

  @override
  State<BookStore> createState() => _BookStoreState();
}

class _BookStoreState extends State<BookStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearchSwitch(
        onChanged: (text) {},
        appBarBuilder: (context) {
          return AppBar(
            title: const Text('Library '),
            actions: const [AppBarSearchButton()],
          );
        },
      ),
      //
      body: CustomScrollView(slivers: [
        SliverList(
            delegate: SliverChildListDelegate.fixed([
          ...[1, 2, 3, 4].map((e) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Flutter'),
                TextButton(
                  onPressed: () {},
                  child: const Text('All'),
                )
              ],
            );
          })
        ])),
      ]),
    );

    // ListView(
    //   controller: ScrollController(),
    //   children: [
    //     CustomScrollView(
    //       shrinkWrap: true,
    //       slivers: [
    //         SliverAppBar(
    //           title: _isVisible
    //               ? SearchBar(
    //                   trailing: [
    //                     CloseButton(color: Colors.black, onPressed: () {})
    //                   ],
    //                   shape: MaterialStateProperty.all(
    //                     RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(10)),
    //                   ),
    //                   // onChanged: (input) {
    //                   //   setState(() {});
    //                   //   searchedList = widget.questions.where((q) {
    //                   //     return q.question.contains(input.toLowerCase());
    //                   //   }).toList();
    //                   // },
    //                   hintText: 'search question..',
    //                   //controller: searchBarController,
    //                   elevation: MaterialStateProperty.all(0),
    //                 )
    //               : null,
    //         ),
    //       ],
    //     ),
    //     ListView.separated(
    //       shrinkWrap: true,
    //       controller: _controller,
    //       itemBuilder: (context, index) {
    //         return Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             const Text('Flutter'),
    //             TextButton(
    //               onPressed: () {},
    //               child: const Text('All'),
    //             )
    //           ],
    //         );
    //       },
    //       separatorBuilder: (context, index) {
    //         return SizedBox(
    //           height: 250,
    //           child: ListView.builder(
    //             controller: ScrollController(),
    //             itemCount: 10,
    //             shrinkWrap: true,
    //             scrollDirection: Axis.horizontal,
    //             itemBuilder: (context, index) {
    //               return Container(
    //                 width: 200,
    //                 color: Colors.red,
    //                 // margin: const EdgeInsets.all(10),
    //               );
    //             },
    //           ),
    //         );
    //       },
    //       itemCount: 5,
    //     )
    //   ],
    // );
  }
}
