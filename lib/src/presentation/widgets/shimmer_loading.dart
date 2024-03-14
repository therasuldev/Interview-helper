import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/decorations/view_utils.dart';

class KShimmer extends StatelessWidget {
  const KShimmer({super.key, this.progress});

  final String? progress;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        color: Colors.white10,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Text(progress ?? '', style: ViewUtils.ubuntuStyle(fontSize: 30)),
      ),
    );
  }
}
