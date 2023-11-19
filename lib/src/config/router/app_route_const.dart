import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:interview_prep/interview_prep_scaffold.dart';
import 'package:interview_prep/src/domain/models/question/question.dart';
import 'package:interview_prep/src/presentation/views/home_screen/home_view.dart';
import 'package:interview_prep/src/presentation/views/home_screen/question_view.dart';
import 'package:interview_prep/src/presentation/views/home_screen/questions_view.dart';
import 'package:interview_prep/src/presentation/views/library_screen/book_view.dart';
import 'package:interview_prep/src/presentation/views/library_screen/library_view.dart';

import '../../domain/models/book/book_view_details.dart';

class AppRouteConstant {
  AppRouteConstant._();
  static String initial = '/';

  static String homeView = '/home_view';
  static String questionsView = 'questions_view';
  static String questionView = 'question_view';

  static String libraryView = '/library_view';
  static String bookView = 'book_view';
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _libraryNavigatorKey = GlobalKey<NavigatorState>();

GoRouter config = GoRouter(
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, body) {
        return InterviewPrepScaffold(body: body);
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
  initialLocation: AppRouteConstant.homeView,
);