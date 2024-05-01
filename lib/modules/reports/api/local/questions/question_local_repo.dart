import 'package:flutter_application_1/modules/reports/api/local/questions/fuctoins/get_question_by_section_id.dart';
import 'package:flutter_application_1/modules/reports/api/local/questions/fuctoins/get_question_data_by_question_id.dart';
import 'package:flutter_application_1/modules/reports/api/local/questions/fuctoins/get_question_options_by_question_id.dart';
import 'package:flutter_application_1/modules/reports/api/local/questions/fuctoins/get_question_options_data_by_questionoptionid.dart';

class QuestionLocalRepo {
  Future<dynamic> getQuestionBySectionId({required String sectionId}) =>
      getQuestionBySectionIdFunc(sectionId: sectionId);

  Future<dynamic> getQuestionOptoinByQuestionId({required String questionId}) =>
      getQuestionOptoinByQuestionIdFunc(questionId: questionId);
  Future<dynamic> getQuestionOptionDataByQustionOptionId(
          {required String qOId}) =>
      getQuestionOptoinDataByQuestionOptionIdFunc(questionOptionId: qOId);

  Future<dynamic> getQuestionInfoByQuestionId({required String questionId}) =>
      getQuestionInfoByQuestionIdFunc(questionId: questionId);
}
