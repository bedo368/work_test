import 'package:flutter_application_1/modules/reports/models/answer_models/project_stage_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/requierd_image_for_question_option_answer_model.dart';
import 'package:hive/hive.dart';

Future<PStageAnswerModel?> addAnswerForImageRequiredForStage(
    {required String pStageId,
    List<RequierdImageAnswerForQuetionOptionModel>?
        reqiredImageanswers}) async {
  try {
    final box = await Hive.openBox<PStageAnswerModel>('PSTAGEANWER');

    final pStageAnswerModel = box.get(pStageId);

    final oldSection = pStageAnswerModel!.pStageSectionsAnswers;

    box.put(
        pStageId,
        PStageAnswerModel(
            pStageId: pStageId,
            imageRequiredForStageSections:
                pStageAnswerModel.imageRequiredForStageSections,
            pStageSectionsAnswers: pStageAnswerModel.pStageSectionsAnswers,
            imageRequiredForStageSectionAnswer: reqiredImageanswers ?? []));
    return pStageAnswerModel;
  } catch (e) {
    return null;
  }
}
