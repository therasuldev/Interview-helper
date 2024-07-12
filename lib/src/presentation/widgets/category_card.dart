import 'package:flutter/material.dart';

import '../../utils/view_utils.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.image, required this.category});

  final String image;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: ViewUtils.categoryCardDecor(),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SizedBox(height: 100, child: Image.asset(image)),
          const Spacer(),
          Text(
            category,
            textAlign: TextAlign.center,
            style: ViewUtils.ubuntuStyle(
              fontSize: 18,
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
