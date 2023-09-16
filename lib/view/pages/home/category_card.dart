import 'package:flutter/material.dart';
import 'package:interview_prep/view/utils/utils.dart';

//TODO encapsulation
class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.image, required this.title});

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: ViewUtils.categoryCardDecor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SizedBox(height: 100, child: Image.asset(image)),
          const Spacer(),
          Text(
            title,
            textAlign: TextAlign.center,
            style: ViewUtils.ubuntuStyle(
              fontSize: 22,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
