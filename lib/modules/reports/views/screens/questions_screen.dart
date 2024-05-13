import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/api/local/pstage/add_project_section_answer_to_pstage_answer.dart';
import 'package:flutter_application_1/modules/reports/api/server/fetch_all_api/fetch_all.dart';
import 'package:flutter_application_1/modules/reports/controllers/questin_cubit/question_cubit.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/project_stage_section_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/section_model.dart';
import 'package:flutter_application_1/modules/reports/models/stage_models.dart';
import 'package:flutter_application_1/modules/reports/views/screens/sections_screen.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/select_question_by_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen(
      {super.key, required this.section, required this.pStageId});
  final SectionModel section;
  final String pStageId;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen>
    with AutomaticKeepAliveClientMixin {
  final contoller = ScrollController();

  List<QuestionAnswerModel> answers = [];

  Future<void> testStore(PStageSectionAnswerModel p) async {
    await addPStageSectionAnswerToPStageAnswer(sectionAnswer: p).then((value) {
      final stagesBox = Hive.box<StageModel>(hiveStageBox);

      final stage = stagesBox.values
          .firstWhere((element) => element.stageID == widget.section.stageID);
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (c) =>
              SectionScreen(stage: stage, pStageId: value!.pStageId)));
    });
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
    final section = widget.section;
    super.build(context);
    return BlocConsumer<QuestionCubit, QuestionState>(
      listener: (context, state) {},
      builder: (context, state) {
        final questionCubit = context.read<QuestionCubit>();

        return Scaffold(
          floatingActionButton: ValueListenableBuilder(
              valueListenable: currentAnswerdrequiredQuestionCount,
              builder: (context, value, w) {
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
                            final res = PStageSectionAnswerModel(
                                pStageId: widget.pStageId,
                                questionAnswers: answers,
                                sectionId: section.sectionID);

                            testStore(res);
                          },
                        ),
                      )
                    : const SizedBox();
              }),
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: Text(widget.section.sectionName),
            // leading: IconButton(
            //   icon: const Icon(Icons.arrow_back),
            //   onPressed: () {},
            // ),
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
                        if (quetionInfo['answer'] != null) {
                          final anser =
                              QuestionAnswerModel.createQuestionAnswer(
                                  questionAndAnserData: quetionInfo,
                                  pStageId: widget.pStageId);

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
