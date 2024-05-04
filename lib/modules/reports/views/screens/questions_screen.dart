import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/controllers/questin_cubit/question_cubit.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/project_stage_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/section_model.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/select_question_by_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.section});
  final SectionModel section;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen>
    with AutomaticKeepAliveClientMixin {
  final contoller = ScrollController();

  List<QuestionAnswerModel> answers = [];

  Future<void> testStore(ProjectStageAnswerModel p) async {
    await p.storeInHive();
    final resfromhive = await p.getFormHive();

    log(resfromhive!.toMap().toString());
  }

  int requiredQuestionCount = 0;
  int currentAnswerdrequiredQuestionCount = 0;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final questionCubit = context.read<QuestionCubit>();

      Future.delayed(Duration.zero).then((value) {
        for (var q in questionCubit.questions) {
          log(q.toMap().toString());
          if (q.required == '1') {
            setState(() {
              requiredQuestionCount++;
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<QuestionCubit, QuestionState>(
      listener: (context, state) {},
      builder: (context, state) {
        final questionCubit = context.read<QuestionCubit>();

        return Scaffold(
          floatingActionButton:
              currentAnswerdrequiredQuestionCount == requiredQuestionCount
                  ? TextButton(
                      child: const Text('try add '),
                      onPressed: () {
                        final res = ProjectStageAnswerModel(
                            pStageId: '88', questionAnswers: answers);

                        testStore(res);
                      },
                    )
                  : null,
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: Text(widget.section.sectionName),
          ),
          body: state is QuestionLoadingState
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return selectQuestionByType(
                      question: questionCubit.questions[index],
                      qOption: questionCubit.questionOption
                          .where((element) =>
                              element.qID == questionCubit.questions[index].qID)
                          .toList(),
                      onSelected: (quetionInfo) {
                        log(quetionInfo.toString());
                        if (quetionInfo['answer'] != null) {
                          final anser =
                              QuestionAnswerModel.createQuestionAnswer(
                                  questionAndAnserData: quetionInfo,
                                  pStageId: '88');

                          final isAnserExistBefore = answers.indexWhere(
                              (element) =>
                                  element.question.qID == anser.question.qID);

                          if (isAnserExistBefore == -1) {
                            answers.add(anser);

                            if (anser.question.required == '1') {
                              Future.delayed(Duration.zero).then(
                                (value) {
                                  setState(() {
                                    currentAnswerdrequiredQuestionCount++;
                                  });
                                },
                              );
                            }
                          } else {
                            answers[isAnserExistBefore] = anser;
                          }
                        } else if (quetionInfo['answer'] == null) {
                          answers.removeWhere((element) =>
                              element.question.qID ==
                              quetionInfo['question'].qID);

                          if (quetionInfo['question'].required == '1') {
                            setState(() {
                              currentAnswerdrequiredQuestionCount--;
                            });
                          }
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: questionCubit.questions.length),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
