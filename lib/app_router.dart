import 'package:flutter_interview_questions/app_route_const.dart';
import 'package:flutter_interview_questions/main.dart';
import 'package:flutter_interview_questions/question_list_page.dart';
import 'package:flutter_interview_questions/question_view.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: AppRouteConstant.home,
        path: '/',
        builder: (context, state) => const ProgrammingLanguages(),
        routes: [
          GoRoute(
            name: AppRouteConstant.questionListView,
            path: 'listv',
            builder: (context, state) => const QuestionListView(),
            routes: [
              GoRoute(
                name: AppRouteConstant.questionView,
                path: 'b',
                builder: (context, state) =>  QuestionView(
                ),
              ),
            ],
          ),
        ],
      )
    ],
  );
}
