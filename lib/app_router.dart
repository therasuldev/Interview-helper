import 'package:flutter_interview_questions/app_route_const.dart';
import 'package:flutter_interview_questions/view/pages/categories/programming_lang_categories.dart';
import 'package:flutter_interview_questions/view/pages/view/question_view.dart';
import 'package:go_router/go_router.dart';
import 'view/pages/questionList/question_list_page.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: AppRouteConstant.home,
        path: '/',
        builder: (context, state) => const ProgrammingLanguageCategories(),
        routes: [
          GoRoute(
            name: AppRouteConstant.questionListView,
            path: 'listv',
            builder: (context, state) => const QuestionListView(),
            routes: [
              GoRoute(
                name: AppRouteConstant.questionView,
                path: 'b',
                builder: (context, state) => const QuestionView(),
              ),
            ],
          ),
        ],
      )
    ],
  );
}
