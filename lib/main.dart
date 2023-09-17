import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:workmanager/workmanager.dart';

import 'package:interview_prep/interview_prep_scaffold.dart';
import 'package:interview_prep/src/data/datasources/local/notification_prefs.dart';
import 'package:interview_prep/src/presentation/provider/bloc/books/books_bloc.dart';
import 'package:interview_prep/src/presentation/provider/bloc/questions/question_bloc.dart';
import 'package:interview_prep/src/presentation/provider/cubit/feedback/feedback_cubit.dart';
import 'package:interview_prep/src/presentation/views/home_screen/home_view.dart';
import 'package:interview_prep/src/presentation/views/library_screen/library_view.dart';
import 'package:interview_prep/src/utils/application_utils.dart';
import 'package:interview_prep/src/utils/enum/kpath_event.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await NotificationUtils.initialize();
    return Future.value(true);
  });
}

Future initialization() async {
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
}

void main() async {
  await Application.start();

  final NotificationPrefs prefs = NotificationPrefs();

  // Background local notifications service
  if ((await prefs.notificationCtrlGet()) ?? false) {
    await Workmanager().initialize(callbackDispatcher);
    await Workmanager().registerPeriodicTask(
      '2',
      'Interview Questions App',
      frequency: const Duration(days: 5),
    );
  }

  final bookBloc = BookBloc()
    ..add(BookEvent.fetchBooksStart(_Helper().categories));

  await initialization();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FeedbackCubit()),
        BlocProvider(create: (context) => QuestionBloc()),
        BlocProvider.value(value: bookBloc)
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    ),
  );
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const InterviewPrepScaffold(screens: [
      HomeView(),
      LibraryView(),
    ]);
  }
}

final class _Helper {
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
