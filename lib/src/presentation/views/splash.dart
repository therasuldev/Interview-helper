import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(child: KSpinKitCircle()),
    );
  }
}
