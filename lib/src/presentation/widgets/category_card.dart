import 'package:flutter/material.dart';
import 'package:interview_prep/src/utils/decorations/view_utils.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required String image, required String title})
      : _image = image,
        _title = title;

  final String _image;
  final String _title;

  String get image => _image;
  String get title => _title;

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
          SizedBox(height: 100, child: Image.asset(_image)),
          const Spacer(),
          Text(
            _title,
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
