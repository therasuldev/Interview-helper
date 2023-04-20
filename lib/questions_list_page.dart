import 'package:flutter/material.dart';
import 'package:flutter_interview_questions/appbar_clipper.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({super.key});

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(240),
          child: ClipPath(
            clipper: MyClipper(),
            child: Container(
                height: 300,
                color: const Color.fromARGB(255, 38, 109, 176),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 50, left: 15, right: 15, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          BackButton(
                            color: Colors.white,
                          ),
                          Text(
                            '1/74',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Text(
                      'What’s the difference between Ephemeral State and App state in flutter ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )),
          )),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Ephemeral State -when your state variables are in inside of the Stateful widget, its known as ephemeral state. When your state variables are in outside of the Stateful widget, its known as App state.(because that state is used by many widgets).",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 89, 97, 107),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        extendedPadding: const EdgeInsetsDirectional.symmetric(horizontal: 40),
        label: const Text(
          'next',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
