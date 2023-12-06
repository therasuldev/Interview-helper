import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:prepare_for_interview/gen/assets.gen.dart';
import 'package:prepare_for_interview/src/config/router/app_router.dart';
import 'package:prepare_for_interview/src/presentation/provider/bloc/introduction/introduction_bloc.dart';
import 'package:prepare_for_interview/src/presentation/provider/bloc/introduction/introduction_event.dart';
import 'package:prepare_for_interview/src/presentation/provider/bloc/introduction/introduction_state.dart';

class AppOnBoarding extends StatefulWidget {
  const AppOnBoarding({super.key});

  @override
  State<AppOnBoarding> createState() => _AppOnBoardingState();
}

class _AppOnBoardingState extends State<AppOnBoarding> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.onboardingViewed!) {
          context.go(AppRouteConstant.homeView);
        }
      },
      child: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Register',
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: Colors.black,
        ),
        skipTextButton: const Text('Skip'),
        trailing: const Text('Login'),
        onFinish: () async {
          context.read<AppBloc>().add(AppEvent.set(true));
        },
        background: [
          Lottie.asset(
            Assets.lotties.interview,
            controller: _controller,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward();
            },
          ),
          Lottie.asset(
            Assets.lotties.books,
            controller: _controller,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward();
            },
          ),
        ],
        totalPage: 2,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('Description Text 1'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('Description Text 2'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
