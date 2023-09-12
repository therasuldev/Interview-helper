import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_prep/application_start.dart';
import 'package:interview_prep/core/app/enum/kpath_event.dart';
import 'package:interview_prep/core/config/api_config.dart';
import 'package:interview_prep/core/provider/books_bloc/books_bloc.dart';
import 'package:interview_prep/core/provider/feedback_cubit/feedback_cubit.dart';
import 'package:interview_prep/core/provider/question_bloc/question_bloc.dart';
import 'package:interview_prep/utils/work_manager_utils.dart';
import 'package:interview_prep/view/general_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  await Application.start();
  await initialization();

  //Background local notifications service
  await Workmanager().initialize(WorkmanagerUtils.callbackDispatcher);
  await Workmanager().registerPeriodicTask(
    '2',
    'Interview Questions App',
    frequency: const Duration(days: 5),
  );

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
        BlocProvider(
          create: (context) => FeedbackCubit(
            apiUrl: ApiConfig().url,
            headers: ApiConfig().headers,
          ),
        ),
        BlocProvider(create: (context) => QuestionBloc()),
        BlocProvider(
          create: (context) =>
              BookBloc()..add(BookEvent.fetchBooksStart(_Helper().categories)),
        ),
      ],
      child: const MaterialApp(
        home: GeneralPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class _Helper {
  Set<Path> get categories => {
        Path.flutter,
        Path.go,
        Path.java,
        Path.python,
        Path.ruby,
        Path.kotlin,
        Path.typescript,
        Path.rust,
        Path.js,
        Path.react,
        Path.csharp,
        Path.nodejs,
        Path.perl,
        Path.php,
        Path.scala,
        Path.swift,
        Path.cplusplus,
        Path.git,
        Path.cybersecurity,
      };
}
