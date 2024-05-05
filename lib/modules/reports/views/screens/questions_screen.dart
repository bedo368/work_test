import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  final ValueNotifier<int> requiredQuestionNo = ValueNotifier<int>(0);
  final ValueNotifier<int> currentAnswerdrequiredQuestionCount =
      ValueNotifier<int>(0);
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final questionCubit = context.read<QuestionCubit>();

      Future.delayed(Duration.zero).then((value) {
        for (var q in questionCubit.questions) {
          log(q.toMap().toString());
          if (q.required == '1') {
            requiredQuestionNo.value += 1;
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
          floatingActionButton: ValueListenableBuilder(
              valueListenable: currentAnswerdrequiredQuestionCount,
              builder: (context, value, widget) {
                print(value);
                return value == requiredQuestionNo.value
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * .5,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                          ),
                          child: const Text(
                            'try add ',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            final res = ProjectStageAnswerModel(
                                pStageId: '88', questionAnswers: answers);

                            testStore(res);
                          },
                        ),
                      )
                    : const SizedBox();
              }),
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
                              Future.delayed(Duration.zero).then((value) {
                                currentAnswerdrequiredQuestionCount.value += 1;
                              });
                            }
                          } else {
                            answers[isAnserExistBefore] = anser;
                          }
                        } else if (quetionInfo['answer'] == null) {
                          answers.removeWhere((element) =>
                              element.question.qID ==
                              quetionInfo['question'].qID);

                          if (quetionInfo['question'].required == '1') {
                            currentAnswerdrequiredQuestionCount.value -= 1;
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
