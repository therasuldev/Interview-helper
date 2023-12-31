import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:interview_helper/src/utils/index.dart';

class KSpinKitCircle extends StatelessWidget {
  const KSpinKitCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpinKitCircle(color: AppColors.primary);
  }
}
