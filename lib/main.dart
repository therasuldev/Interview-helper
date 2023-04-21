import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/app_router.dart';
import 'package:flutter_interview_questions/gen/assets.gen.dart';
import 'package:flutter_interview_questions/question_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter().router,
    );
  }
}

class ProgrammingLanguages extends StatefulWidget {
  const ProgrammingLanguages({super.key});

  @override
  State<ProgrammingLanguages> createState() => _ProgrammingLanguagesState();
}

class _ProgrammingLanguagesState extends State<ProgrammingLanguages> {
  //* programming lang. images
  final List<String> _langPNGs = [
    Assets.programmingLangPng.flutter.path,
    Assets.programmingLangPng.go.path,
  ];

  //* programming lang. names
  final List<String> _langNames = [
    'Flutter',
    'Go lang',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: _langPNGs.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          childAspectRatio: 1,
          mainAxisSpacing: 30,
        ),
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const QuestionView(),
                    ),
                    (route) => true);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 10),
                      spreadRadius: .5,
                      blurRadius: 10,
                    )
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.blueGrey[200]!,
                    ],
                    stops: const [0.5, 1],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    SizedBox(height: 100, child: Image.asset(_langPNGs[i])),
                    const Spacer(),
                    Text(
                      _langNames[i],
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.grey[600]!.withRed(50),
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const Spacer(),
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
