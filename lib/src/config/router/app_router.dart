import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_for_interview/src/presentation/views/onboarding_screen.dart';

import '../../../app_scaffold.dart';
import '../../domain/models/models.dart';
import '../../presentation/views/home_screen/home.dart';
import '../../presentation/views/library_screen/library.dart';

class AppRouteConstant {
  AppRouteConstant._();
  static const String initial = '/';
  static const String onboarding = '/onboarding';

  static const String homeView = '/home_view';
  static const String questionsView = 'questions_view';
  static const String questionView = 'question_view';

  static const String libraryView = '/library_view';
  static const String allBooks = 'all_books';
  static const String bookView = 'book_view';
  static const String openBook = 'open_book';
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _libraryNavigatorKey = GlobalKey<NavigatorState>();

class AppRouterConfig {
  AppRouterConfig._init();

  static AppRouterConfig? _instance;
  static AppRouterConfig get instance {
    return _instance ??= AppRouterConfig._init();
  }

  final GoRouter config = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: AppRouteConstant.onboarding,
        name: AppRouteConstant.onboarding,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return NoTransitionPage(child: AppOnBoarding(key: state.pageKey));
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, body) {
          return AppScaffold(key: state.pageKey, body: body);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: AppRouteConstant.homeView,
                name: AppRouteConstant.homeView,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return NoTransitionPage(child: HomeView(key: state.pageKey));
                },
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: AppRouteConstant.questionsView,
                    name: AppRouteConstant.questionsView,
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      final questions = (state.extra as List).cast<Question>();
                      final appBarTitle = state.uri.queryParameters['appBarTitle'];
                      return MaterialPage(
                        child: QuestionsView(
                          key: state.pageKey,
                          questions: questions,
                          appBarTitle: appBarTitle,
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        path: AppRouteConstant.questionView,
                        name: AppRouteConstant.questionView,
                        pageBuilder: (BuildContext context, GoRouterState state) {
                          final questions = (state.extra as List).cast<Question>();
                          final index = int.parse(state.uri.queryParameters['index']!);
                          return MaterialPage(
                            child: QuestionView(
                              index: index,
                              key: state.pageKey,
                              questions: questions,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _libraryNavigatorKey,
            routes: [
              GoRoute(
                path: AppRouteConstant.libraryView,
                name: AppRouteConstant.libraryView,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return NoTransitionPage(child: LibraryView(key: state.pageKey));
                },
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: AppRouteConstant.bookView,
                    name: AppRouteConstant.bookView,
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      final bookViewDetails = state.extra as BookViewDetails;
                      return MaterialPage(
                        child: BookView(
                          key: state.pageKey,
                          book: bookViewDetails.book,
                          index: bookViewDetails.index,
                          otherBooks: bookViewDetails.otherBooks,
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        path: AppRouteConstant.openBook,
                        name: AppRouteConstant.openBook,
                        pageBuilder: (BuildContext context, GoRouterState state) {
                          final book = state.extra as Book;
                          return MaterialPage(
                            child: OpenPDFView(
                              key: state.pageKey,
                              book: book,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: AppRouteConstant.allBooks,
                    name: AppRouteConstant.allBooks,
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      final books = (state.extra as List).cast<Book>();
                      return MaterialPage(
                        child: AllBooksOfCategory(key: state.pageKey, books: books),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      )
    ],
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRouteConstant.onboarding,
  );
}
