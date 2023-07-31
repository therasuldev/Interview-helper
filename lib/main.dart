import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview_questions/application_start.dart';
import 'package:flutter_interview_questions/core/app/enum/kpath_event.dart';
import 'package:flutter_interview_questions/core/provider/books_bloc/books_bloc.dart';
import 'package:flutter_interview_questions/core/provider/question_bloc/question_bloc.dart';
import 'package:flutter_interview_questions/view/general_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  await Application.start();
  await initialization();
  runApp(const MyApp());
}

Future initialization() async {
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => QuestionBloc()),
        BlocProvider(
          create: (context) => BookBloc()
            ..add(
              BookEvent.fetchBooksStart(
                [
                  Path.flutter,
                  Path.go,
                ],
              ),
            ),
        ),
      ],
      child: const MaterialApp(
        home: GeneralPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
