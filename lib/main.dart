import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/app_router.dart';
import 'package:flutter_interview_questions/questions_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: AppRouter().roter.routeInformationParser,
      routerDelegate: AppRouter().roter.routerDelegate,
      //home: ProgrammingLanguages(),
    );
  }
}

class ProgrammingLanguages extends StatefulWidget {
  const ProgrammingLanguages({super.key});

  @override
  State<ProgrammingLanguages> createState() => _ProgrammingLanguagesState();
}

class _ProgrammingLanguagesState extends State<ProgrammingLanguages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          itemCount: 4,
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade700,
                        offset: const Offset(0, 10),
                        spreadRadius: .5,
                        blurRadius: 10,
                      )
                    ],
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.black38,
                        ]),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                          height: 150, child: FlutterLogo(size: 100)),
                      const SizedBox(height: 10),
                      Text(
                        "Flutter&Dart",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
