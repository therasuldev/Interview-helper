import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/app_route_const.dart';
import 'package:flutter_interview_questions/main.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GoRouter roter = GoRouter(
    routes: [
      GoRoute(
        name: AppRouteConstant.home,
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: MyApp());
        },
      ),
      GoRoute(
        name: 'profile',
        path: '/profile',
        pageBuilder: (context, state) {
          return const MaterialPage(child: MyApp());
        },
      ),
    ],
  );
}
