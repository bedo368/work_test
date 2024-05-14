import 'package:flutter_application_1/modules/reports/models/answer_models/project_stage_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/project_stage_section_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/requierd_image_for_question_option_answer_model.dart';
import 'package:hive/hive.dart';

Future<PStageAnswerModel?> addPStageSectionAnswerToPStageAnswer({
  required PStageSectionAnswerModel sectionAnswer,
}) async {
  try {
    final String pstagId = sectionAnswer.pStageId;

    final box = await Hive.openBox<PStageAnswerModel>('PSTAGEANWER');

    final pStageAnswerModel = box.get(pstagId);

    if (pStageAnswerModel == null) {
      final pStageAnswerModel = PStageAnswerModel.createWithImageRequired(
          sectionsAnswers: [sectionAnswer]);

      box.put(pstagId, pStageAnswerModel);
      return pStageAnswerModel;
    } else {
      final oldSection = pStageAnswerModel.pStageSectionsAnswers;
      oldSection.add(sectionAnswer);

      box.put(
          pstagId,
          PStageAnswerModel.createWithImageRequired(
            sectionsAnswers: oldSection,
          ));
      return pStageAnswerModel;
    }
  } catch (e) {
    return null;
  }
}
