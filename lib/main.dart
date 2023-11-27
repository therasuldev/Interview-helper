import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:workmanager/workmanager.dart';

import './src/utils/enum/enums.dart';
import 'src/config/router/app_route_const.dart';
import 'src/data/datasources/local/notification_prefs.dart';
import 'src/presentation/provider/bloc/books/books_bloc.dart';
import 'src/presentation/provider/bloc/questions/question_bloc.dart';
import 'src/presentation/provider/cubit/feedback/feedback_cubit.dart';
import 'src/utils/application_utils.dart';

const _backgroundServiceUniqueName = '1';
const _backgroundServiceTaskName = 'InterviewPrepApp';

@pragma('vm:entry-point')
void callbackDispatcher() {
  final NotificationPrefs prefs = NotificationPrefs();
  Workmanager().executeTask((task, data) async {
    if ((await prefs.notificationCtrlGet()) ?? false) {
      NotificationUtils().initialize();
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
  BackgroundService.init();

  await Application.start();
  await initialization();

  BackgroundService.registerBackgroundUpdates();

  runApp(const MyApp());
}

class BackgroundService {
  static void init() {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: kDebugMode,
    );
  }

  static void registerBackgroundUpdates() {
    Workmanager().registerPeriodicTask(
      _backgroundServiceUniqueName,
      _backgroundServiceTaskName,
      //frequency: const Duration(minutes: 15),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FeedbackCubit()),
        BlocProvider(create: (context) => QuestionBloc()),
        BlocProvider(create: (context) => BookBloc()..add(BookEvent.fetchBooksStart(_Helper.categories)))
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouterConfig.instance.config,
      ),
    );
  }
}

final class _Helper {
  static Set<Path> get categories => {
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
