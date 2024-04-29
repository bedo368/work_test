import 'package:flutter_application_1/modules/reports/api/local/questions/fuctoins/get_question_options_by_questionId.dart';
import 'package:flutter_application_1/modules/reports/api/local/questions/fuctoins/get_question_options_data_by_questionoptionid.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_data_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';

Future<dynamic> getQuestionInfoByQuestionIdFunc(
    {required String questionId}) async {
  try {
    final qOptions =
        await getQuestionOptoinByQuestionIdFunc(questionId: questionId);
    List<QuestionsOptionDModel> qustionOptions = [];

    for (var q in (qOptions as List<QuestionOptionsModel>)) {
      final qOptionData = await getQuestionOptoinDataByQuestionOptionIdFunc(
          questionOptionId: q.qOID);
      qustionOptions.addAll(qOptionData);
    }

    final questiondata = {"option": qOptions, "optionData": qustionOptions};
    return questiondata ;
  } catch (e) {
    rethrow;
  }
}
