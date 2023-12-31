import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:interview_helper/gen/assets.gen.dart';
import 'package:interview_helper/src/presentation/provider/bloc/introduction/introduction_bloc.dart';
import 'package:interview_helper/src/presentation/views/splash.dart';
import 'package:interview_helper/src/utils/constants/introduction_screen_description_texts.dart';
import 'package:interview_helper/src/utils/decorations/view_utils.dart';

import 'library_screen/index.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.onboardingViewed!) {
          context.go(AppRouteConstant.homeView);
        }
      },
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state.loading || state.onboardingViewed!) {
            return const Splash();
          }

          return OnBoardingSlider(
            finishButtonStyle: const FinishButtonStyle(backgroundColor: Colors.black),
            onFinish: () async => context.read<AppBloc>().add(AppEvent.set(true)),
            background: introductionIcons(context),
            pageBodies: introductionDescriptions,
            headerBackgroundColor: Colors.white,
            pageBackgroundColor: Colors.white,
            finishButtonText: 'Done',
            totalPage: 2,
            speed: 1.8,
          );
        },
      ),
    );
  }

  List<Widget> introductionIcons(BuildContext context) {
    return [
      SizedBox(
        height: MediaQuery.sizeOf(context).height * .5,
        width: MediaQuery.sizeOf(context).width,
        child: SvgPicture.asset(Assets.introduction.books),
      ),
      SizedBox(
        height: MediaQuery.sizeOf(context).height * .5,
        width: MediaQuery.sizeOf(context).width,
        child: SvgPicture.asset(Assets.introduction.questions),
      ),
    ];
  }

  List<Widget> get introductionDescriptions {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 350, left: 10, right: 10),
        child: Text(
          Description.aboutBooks,
          textAlign: TextAlign.justify,
          style: ViewUtils.ubuntuStyle(fontSize: 22),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 370, left: 10, right: 10),
        child: Text(
          Description.aboutQuestions,
          textAlign: TextAlign.justify,
          style: ViewUtils.ubuntuStyle(fontSize: 22),
        ),
      ),
    ];
  }
}
