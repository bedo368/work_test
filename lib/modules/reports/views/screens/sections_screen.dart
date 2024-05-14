import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/controllers/questin_cubit/question_cubit.dart';
import 'package:flutter_application_1/modules/reports/controllers/section_cubit/sections_cubit.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/project_stage_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/requierd_image_question_model.dart';
import 'package:flutter_application_1/modules/reports/models/stage_models.dart';
import 'package:flutter_application_1/modules/reports/views/screens/image_required_questions_screen.dart';
import 'package:flutter_application_1/modules/reports/views/screens/questions_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class SectionScreen extends StatefulWidget {
  const SectionScreen({super.key, required this.stage, required this.pStageId});
  final StageModel stage;
  final String pStageId;

  @override
  State<SectionScreen> createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  int sectionNom = 0;
  int tempanswerdSectionNOm = 0;
  final ValueNotifier<int> answerdSectionNOm = ValueNotifier<int>(0);
  final box = Hive.box<PStageAnswerModel>('PSTAGEANWER');
  List<RequiredImageModel> imageRequiredList = [];
  bool isDone = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final stagesForThisPStageId = box.get(widget.pStageId);
      if (stagesForThisPStageId != null) {
        imageRequiredList = stagesForThisPStageId.imageRequiredForStageSections;

        answerdSectionNOm.value =
            stagesForThisPStageId.pStageSectionsAnswers.length;
        log('stagesForThisPStageId.getImageRequiredCount ${stagesForThisPStageId.getImageRequiredCount().toString()}');
        log('----------');
        log(stagesForThisPStageId.imageRequiredForStageSectionAnswer.length
            .toString());
        if (stagesForThisPStageId.getImageRequiredCount() ==
            stagesForThisPStageId.imageRequiredForStageSectionAnswer.length) {
          isDone = true;
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SectionsCubit>(
        create: (context) => SectionsCubit()
          ..fetchSectionByStageId(stageId: widget.stage.stageID),
        child: BlocConsumer<SectionsCubit, SectionsState>(
          listener: (context, state) {},
          builder: (context, state) {
            final sectionCubit = context.read<SectionsCubit>();
            sectionNom = sectionCubit.section.length;
            log(sectionNom.toString());
            log(answerdSectionNOm.value.toString());
            if (sectionNom != answerdSectionNOm.value) {
              isDone = false;
            }

            return Scaffold(
              floatingActionButton: ValueListenableBuilder<int>(
                  valueListenable: answerdSectionNOm,
                  builder: (context, value, w) {
                    return value == sectionNom && isDone
                        ? ElevatedButton(
                            child: const Text('show Stored '),
                            onPressed: () {
                              final stagesForThisPStageId =
                                  box.get(widget.pStageId);
                              log(stagesForThisPStageId!.toString());
                            },
                          )
                        : const SizedBox();
                  }),
              appBar: AppBar(
                title: Text(widget.stage.stageName),
              ),
              body: ListView.separated(
                  itemBuilder: (context, index) {
                    final pStageAnswer = box.get(widget.pStageId);
                    bool isAnswerd = false;

                    if (index < sectionCubit.section.length) {
                      if (pStageAnswer == null) {
                        isAnswerd = false;
                      } else {
                        for (var q in pStageAnswer.pStageSectionsAnswers) {
                          if (q.sectionId ==
                              sectionCubit.section[index].sectionID) {
                            isAnswerd = true;
                          }
                        }
                      }
                    }

                    return state is SectionsLoadingState
                        ? const CircularProgressIndicator()
                        : index < sectionCubit.section.length
                            ? TextButton(
                                onPressed: () {
                                  if (isAnswerd == true) {
                                    return;
                                  }
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (contet) => BlocProvider(
                                                create: (context) => QuestionCubit()
                                                  ..fetchQuestionAndQutionDataBySectionId(
                                                    sectionId: sectionCubit
                                                        .section[index]
                                                        .sectionID,
                                                  ),
                                                child: QuestionScreen(
                                                  section: sectionCubit
                                                      .section[index],
                                                  pStageId: widget.pStageId,
                                                ),
                                              )))
                                      .then((value) {});
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(sectionCubit
                                        .section[index].sectionName),
                                    isAnswerd == false
                                        ? const SizedBox()
                                        : const Icon(Icons.check),
                                  ],
                                ))
                            : ValueListenableBuilder<int>(
                                valueListenable: answerdSectionNOm,
                                builder: (context, value, w) {
                                  return TextButton(
                                      onPressed: () {
                                        log(value.toString());
                                        log(sectionNom.toString());

                                        // if ((!isDone && value < sectionNom)) {
                                        //   return;
                                        // }
                                        if (isDone) {
                                          return;
                                        }
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                              builder: (contet) =>
                                                  ImageRequredQuestionScreen(
                                                stage: widget.stage,
                                                pStageId: widget.pStageId,
                                                imageQuestion:
                                                    imageRequiredList,
                                              ),
                                            ))
                                            .then((value) {});
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('image for all sections'),
                                          value < sectionNom
                                              ? const Icon(Icons.cancel)
                                              : isDone
                                                  ? const Icon(Icons.check)
                                                  : const SizedBox()
                                        ],
                                      ));
                                });
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: sectionCubit.section.length + 1),
            );
          },
        ));
  }
}
