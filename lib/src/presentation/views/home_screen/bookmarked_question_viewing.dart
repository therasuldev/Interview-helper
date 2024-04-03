import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interview_helper/gen/assets.gen.dart';
import 'package:interview_helper/src/presentation/provider/bloc/category/category_bloc.dart';
import 'package:interview_helper/src/utils/index.dart';

import '../../../domain/models/index.dart';
import '../../widgets/index.dart';

class BookmarkedQuestionViewing extends StatefulWidget {
  const BookmarkedQuestionViewing({
    super.key,
    required this.question,
    required this.category,
  });

  final Question question;
  final String category;

  @override
  State<BookmarkedQuestionViewing> createState() => _BookmarkedQuestionViewingState();
}

class _BookmarkedQuestionViewingState extends State<BookmarkedQuestionViewing> with _QuestionViewMixin {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(CategoryEvent.fetchBookmarkedQuestionsForCategory(widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state.loading!) return const SizedBox.shrink();

        final isSaved = state.questions?.isSaved(widget.question);
        return Scaffold(
          body: CustomScrollView(
            key: ValueKey(widget.question.question),
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      if (isSaved ?? false) {
                        BlocProvider.of<CategoryBloc>(context).add(
                          CategoryEvent.removeBookmarkedQuestion(
                            widget.category,
                            widget.question,
                          ),
                        );
                      } else {
                        BlocProvider.of<CategoryBloc>(context).add(
                          CategoryEvent.bookmarkQuestionInitial(
                            widget.category,
                            widget.question,
                          ),
                        );
                      }
                    },
                    icon: SvgPicture.asset(
                      Assets.svg.bookmark,
                      color: (isSaved ?? false) ? Colors.orange.shade900 : Colors.white,
                    ),
                  )
                ],
                pinned: true,
                backgroundColor: appBarColor,
                expandedHeight: MediaQuery.sizeOf(context).height * .5,
                flexibleSpace: _QuestionView(question: widget.question),
              ),
              SliverToBoxAdapter(
                child: _AnswerView(
                  question: widget.question,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _QuestionView extends StatelessWidget {
  const _QuestionView({required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: ClipPath(
        clipper: MyClipper(),
        child: ColoredBox(
          color: AppColors.primary,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Text(
                question.question,
                textAlign: TextAlign.center,
                style: ViewUtils.ubuntuStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnswerView extends StatelessWidget {
  const _AnswerView({required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        question.answer,
        textAlign: TextAlign.justify,
        style: ViewUtils.ubuntuStyle(
          fontSize: 25,
          color: const Color.fromARGB(255, 89, 97, 107),
        ),
      ),
    );
  }
}

mixin _QuestionViewMixin on State<BookmarkedQuestionViewing> {
  late ScrollController _scrollController;
  Color appBarColor = Colors.transparent;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset > 200) {
          setState(() => appBarColor = AppColors.primary);
        } else if (_scrollController.offset <= 200) {
          setState(() => appBarColor = Colors.transparent);
        }
      });

    BlocProvider.of<CategoryBloc>(context).add(
      CategoryEvent.fetchBookmarkedQuestionsForCategory(widget.category),
    );
  }
}

extension on List<Question> {
  bool isSaved(Question question) {
    return any((bq) {
      return bq == question;
    });
  }
}
