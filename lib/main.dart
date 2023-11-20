import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:workmanager/workmanager.dart';

import 'package:interview_prep/src/config/router/app_route_const.dart';
import 'package:interview_prep/src/data/datasources/local/notification_prefs.dart';
import 'package:interview_prep/src/presentation/provider/bloc/books/books_bloc.dart';
import 'package:interview_prep/src/presentation/provider/bloc/questions/question_bloc.dart';
import 'package:interview_prep/src/presentation/provider/cubit/feedback/feedback_cubit.dart';
import 'package:interview_prep/src/utils/application_utils.dart';
import 'package:interview_prep/src/utils/enum/kpath_event.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  final NotificationPrefs prefs = NotificationPrefs();

  Workmanager().executeTask((_, __) async {
    if ((await prefs.notificationCtrlGet()) ?? false) {
      await NotificationUtils().initialize();
    }
    return Future.value(true);
  });
}

Future initialization() async {
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Application.start();

  // Background local notifications service
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: kDebugMode,
  );

  Workmanager().registerPeriodicTask(
    "3",
    'Interview Questions App',
    frequency: const Duration(minutes: 15),
  );

  await initialization();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FeedbackCubit()),
        BlocProvider(create: (context) => QuestionBloc()),
        BlocProvider(create: (context) => BookBloc()..add(BookEvent.fetchBooksStart(_Helper().categories)))
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: config,
      ),
    );
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
