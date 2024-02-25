import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_helper/src/presentation/views/home_screen/bookmark_view.dart';
import 'package:interview_helper/src/presentation/views/introduction_screen.dart';
import 'package:interview_helper/src/presentation/views/library_screen/bookmarked_book_viewing.dart';

import '../../../app_scaffold.dart';
import '../../domain/models/index.dart';
import '../../presentation/views/home_screen/index.dart';
import '../../presentation/views/library_screen/index.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _libraryNavigatorKey = GlobalKey<NavigatorState>();

class AppRouterConfig {
  AppRouterConfig._();

  static final AppRouterConfig _init = AppRouterConfig._();
  static AppRouterConfig get init => _init;

  final GoRouter config = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: AppRouteConstant.onboarding,
        name: AppRouteConstant.onboarding,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return NoTransitionPage(child: IntroductionScreen(key: state.pageKey));
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
                      path: AppRouteConstant.bookmark,
                      name: AppRouteConstant.bookmark,
                      pageBuilder: (BuildContext context, GoRouterState state) {
                        return MaterialPage(
                          child: BookmarkedDatas(key: state.pageKey),
                        );
                      },
                      routes: [
                        GoRoute(
                          parentNavigatorKey: _rootNavigatorKey,
                          path: AppRouteConstant.bookmarkedBookViewing,
                          name: AppRouteConstant.bookmarkedBookViewing,
                          pageBuilder: (BuildContext context, GoRouterState state) {
                            final bookViewDetails = state.extra as BookViewDetails;
                            return MaterialPage(
                              child: BookmarkedBookViewing(
                                key: ValueKey(bookViewDetails.book.name),
                                category: bookViewDetails.category ?? '',
                                book: bookViewDetails.book,
                              ),
                            );
                          },
                        ),
                      ]),
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: AppRouteConstant.questionsView,
                    name: AppRouteConstant.questionsView,
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      final questions = (state.extra as List).cast<Question>();
                      final category = state.uri.queryParameters['category'];
                      return MaterialPage(
                        child: QuestionsView(key: state.pageKey, questions: questions, category: category),
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
                          final category = state.uri.queryParameters['category']!;
                          return MaterialPage(
                            child: QuestionView(
                              index: index,
                              key: state.pageKey,
                              questions: questions,
                              category: category,
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
                          key: ValueKey(bookViewDetails.book.name),
                          category: bookViewDetails.category ?? '',
                          book: bookViewDetails.book,
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
                          final filePath = state.extra as String;
                          return MaterialPage(
                            child: OpenPDFView(key: state.pageKey, filePath: filePath),
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
                      final category = state.uri.queryParameters['category']!;

                      return MaterialPage(
                        child: AllBooksOfCategory(
                          key: state.pageKey,
                          books: books,
                          category: category,
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        path: AppRouteConstant.bookView,
                        name: 'allBooks_${AppRouteConstant.bookView}',
                        pageBuilder: (BuildContext context, GoRouterState state) {
                          final bookViewDetails = state.extra as BookViewDetails;
                          return MaterialPage(
                            child: BookView(
                              key: ValueKey(bookViewDetails.book.name),
                              category: bookViewDetails.category!,
                              // index: bookViewDetails.index,
                              book: bookViewDetails.book,
                              otherBooks: bookViewDetails.otherBooks,
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
        ],
      )
    ],
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRouteConstant.onboarding,
  );
}
