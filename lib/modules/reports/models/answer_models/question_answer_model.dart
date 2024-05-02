import 'package:flutter_application_1/modules/reports/models/answer_models/checkbox_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/radio_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';

abstract class QuestionAnswerModel {
  QuestionModel question;
  String pStageId;

  QuestionAnswerModel({required this.question, required this.pStageId});

  factory QuestionAnswerModel.createQuestionAnswer({
    required Map<String, dynamic> questionAndAnserData,
    required String pStageId,
  }) {
    if ((questionAndAnserData['question'] as QuestionModel).answerType ==
        'Radio') {
      return RadioQuestionAnswerModel(
        questionOption: questionAndAnserData['answer'],
        question: questionAndAnserData['question'],
        pStageId: pStageId,
      );
    } else if ((questionAndAnserData['question'] as QuestionModel).answerType ==
        'CheckBox') {
      return CheckboxQuestionAnswerModel(
          questionOptions: questionAndAnserData['answer'],
          question: questionAndAnserData['question'],
          pStageId: pStageId);
    } else {
      throw Error();
    }
  }

  Map<String, dynamic> toMap() {
    return {};
  }

  static fromMap(Map<String, dynamic> map) {}
}
