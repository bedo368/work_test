import 'package:flutter_application_1/modules/reports/models/answer_models/checkbox_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/dropdwon_question_anser_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/file_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/image_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/ins_check_list_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/observation_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/radio_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/text_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/user_select_question_answer_model.dart';
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
    } else if ((questionAndAnserData['question'] as QuestionModel).answerType ==
            'Text' ||
        (questionAndAnserData['question'] as QuestionModel).answerType ==
            "TextArea") {
      return TextQuestionAnswerModel(
          answer: questionAndAnserData['answer'],
          question: questionAndAnserData['question'],
          pStageId: pStageId);
    } else if ((questionAndAnserData['question'] as QuestionModel).answerType ==
        'Dropdown') {
      return DropDownQuestionAnswerModel(
          questionOption: questionAndAnserData['answer'],
          question: questionAndAnserData['question'],
          pStageId: pStageId);
    } else if ((questionAndAnserData['question'] as QuestionModel).answerType ==
        'InsChecklist') {
      return InsCheckListQuestionAnswerModel(
          questionOption: questionAndAnserData['answer'],
          question: questionAndAnserData['question'],
          pStageId: pStageId);
    } else if ((questionAndAnserData['question'] as QuestionModel).answerType ==
        'File') {
      return FileQuestionAnswerModel(
          questionOption: questionAndAnserData['answer'],
          question: questionAndAnserData['question'],
          pStageId: pStageId);
    } else if ((questionAndAnserData['question'] as QuestionModel).answerType ==
        'Image') {
      return ImageQuestionAnswerModel(
          questionOptions: questionAndAnserData['answer'],
          question: questionAndAnserData['question'],
          pStageId: pStageId);
    } else if ((questionAndAnserData['question'] as QuestionModel).answerType ==
        'UserSelect') {
      return UserSelectQuestionAnswerModel(
          questionOption: questionAndAnserData['answer']['questionOption'],
          questionOptionData: questionAndAnserData['answer']
              ['questionOptionData'],
          question: questionAndAnserData['question'],
          pStageId: pStageId);
    } else if ((questionAndAnserData['question'] as QuestionModel).answerType ==
        'Observation') {
      return ObservationQuestionAnswerModel(
          questionOption: questionAndAnserData['answer']['questionOption'],
          questionOptionData: questionAndAnserData['answer']
              ['questionOptionData'],
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
