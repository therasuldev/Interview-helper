import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:workmanager/workmanager.dart';

import 'src/config/init/application_initialize.dart';
import 'src/config/notification/notification_initialize.dart';
import 'src/config/router/app_router.dart';
import 'src/data/datasources/local/notification_prefs_service.dart';
import 'src/presentation/provider/bloc/books/books_bloc.dart';
import 'src/presentation/provider/bloc/introduction/introduction_bloc.dart';
import 'src/presentation/provider/bloc/questions/question_bloc.dart';
import 'src/presentation/provider/cubit/feedback/feedback_cubit.dart';
import 'src/utils/constants/helper.dart';

const _backgroundServiceUniqueName = '1';
const _backgroundServiceTaskName = 'InterviewPrepApp';

@pragma('vm:entry-point')
void callbackDispatcher() {
  final NotificationPrefsServiceImpl prefs = NotificationPrefsServiceImpl();
  Workmanager().executeTask((task, data) async {
    //if ((await prefs.getNotificationState()) ?? false) {
    await Notifications.initialize();
    //}
    return Future.value(true);
  });
}

Future splashInitialize() async {
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //BackgroundService.init();

  await Application.initialize();
  await splashInitialize();

  //BackgroundService.registerBackgroundUpdates();
  //   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: AppPalette.transparentColor,
  // ));

  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const InterviewHelper());
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
      frequency: const Duration(hours: 1),
    );
  }
}

class InterviewHelper extends StatelessWidget {
  const InterviewHelper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppBloc()..add(AppEvent.get())),
        BlocProvider(create: (context) => FeedbackCubit()),
        BlocProvider(create: (context) => QuestionBloc()),
        BlocProvider(create: (context) => BookBloc()..add(BookEvent.fetchBooksStart(Helper.categories)))
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouterConfig.instance.config,
      ),
    );
  }
}
