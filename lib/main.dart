import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:interview_helper/src/config/notification/one_signal_config.dart';
import 'package:interview_helper/src/presentation/provider/cubit/language/language_cubit.dart';

import 'src/config/app/app_config.dart';

import 'src/config/hive/hive_config.dart';
import 'src/config/router/router_config.dart';
import 'src/config/theme/theme_config.dart';

import 'src/presentation/provider/bloc/books/books_bloc.dart';
import 'src/presentation/provider/bloc/category/category_bloc.dart';
import 'src/presentation/provider/bloc/introduction/introduction_bloc.dart';
import 'src/presentation/provider/bloc/questions/question_bloc.dart';
import 'src/presentation/provider/cubit/feedback/feedback_cubit.dart';
import 'src/utils/index.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();

  // .env config
  await dotenv.load(fileName: ".env");
  // Firebase and Orientation config
  await AppConfig.config.init();
  // Hive service
  await HiveConfig.config.init();
  // Push notification service
  OneSignalConfig.config.init();

  FlutterNativeSplash.remove();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', ''), Locale('tr', ''), Locale('ru', '')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', ''),
      child: const InterviewHelper(),
    ),
  );
}

class InterviewHelper extends StatelessWidget {
  const InterviewHelper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppBloc()..add(AppEvent.get())),
        BlocProvider(create: (context) => FeedbackCubit()),
        BlocProvider(create: (context) => LanguageCubit()..loadLanguage()),
        BlocProvider(create: (context) => QuestionBloc()),
        BlocProvider(create: (context) => BookBloc()..add(BookEvent.fetchAllBooksStart())),
        BlocProvider(create: (context) => CategoryBloc()),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state.loading) return const SizedBox.shrink();
          return MaterialApp.router(
            title: 'Interview Helper App',
            restorationScopeId: 'interview_helper',
            debugShowCheckedModeBanner: false,
            theme: ThemeConfig.init.theme,
            routerConfig: AppRouterConfig.init.config,
            scaffoldMessengerKey: ViewUtils.scaffoldMessengerKey,
            locale: !state.onboardingViewed! ? View.of(context).platformDispatcher.locale : context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
          );
        },
      ),
    );
  }
}
