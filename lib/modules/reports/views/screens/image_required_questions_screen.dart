import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/api/local/pstage/add_project_section_answer_to_pstage_answer.dart';
import 'package:flutter_application_1/modules/reports/api/local/pstage/add_required_question_images.dart';
import 'package:flutter_application_1/modules/reports/api/server/fetch_all_api/fetch_all.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/project_stage_section_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/requierd_image_for_question_option_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/requierd_image_question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/stage_models.dart';
import 'package:flutter_application_1/modules/reports/views/screens/sections_screen.dart';

import 'package:flutter_application_1/modules/reports/views/widgets/image_question_widget.dart';

class ImageRequredQuestionScreen extends StatefulWidget {
  const ImageRequredQuestionScreen({
    super.key,
    required this.imageQuestion,
    required this.pStageId,
    required this.stage,
  });

  final String pStageId;
  final StageModel stage;

  final List<RequiredImageModel> imageQuestion;

  @override
  State<ImageRequredQuestionScreen> createState() =>
      _ImageRequredQuestionScreenState();
}

class _ImageRequredQuestionScreenState extends State<ImageRequredQuestionScreen>
    with AutomaticKeepAliveClientMixin {
  final contoller = ScrollController();

  List<RequierdImageAnswerForQuetionOptionModel> answers = [];

  Future<void> testStore(
      List<RequierdImageAnswerForQuetionOptionModel> ans) async {
    addAnswerForImageRequiredForStage(
            pStageId: widget.pStageId, reqiredImageanswers: ans)
        .then((value) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (c) =>
              SectionScreen(stage: widget.stage, pStageId: value!.pStageId)));
    });
  }

  final ValueNotifier<int> requiredQuestionNo = ValueNotifier<int>(0);
  final ValueNotifier<int> currentAnswerdrequiredQuestionCount =
      ValueNotifier<int>(0);
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButton: ValueListenableBuilder(
          valueListenable: currentAnswerdrequiredQuestionCount,
          builder: (context, value, w) {
            return answers.length == widget.imageQuestion.length
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
                        testStore(answers);
                        // final res = PStageSectionAnswerModel(
                        //     pStageId: widget.pStageId,
                        //     questionAnswers: answers,
                        //     sectionId: section.sectionID);
                      },
                    ),
                  )
                : const SizedBox();
          }),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('image required for all sections'),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {},
        // ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Question : ${widget.imageQuestion[index].question.qTitle}'),
                Text(
                    'Answer : ${widget.imageQuestion[index].questionOption.answer}'),
                ImageQuestionWidget(
                  onSelected: (quetionInfo) {
                    if (quetionInfo
                        is RequierdImageAnswerForQuetionOptionModel) {
                      setState(() {
                        answers.add(quetionInfo);
                      });
                    }
                    if (quetionInfo is QuestionModel) {
                      setState(() {
                        answers.removeWhere((element) =>
                            element.question.qID == quetionInfo.qID);
                      });
                    }

                    log(answers.toString());
                  },
                  imageCountForImageRequired:
                      widget.imageQuestion[index].imageCount,
                  question: widget.imageQuestion[index].question,
                  questionOption: widget.imageQuestion[index].questionOption,
                )
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: widget.imageQuestion.length),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
