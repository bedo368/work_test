import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/check_list_question.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/drop_dwon_question.dart';

Widget selectQuestionByType(
    {required QuestionModel question,
    required List<QuestionOptionsModel> qOption}) {
  switch (question.answerType) {
    case 'InsChecklist':
      return CheckListQuestionWidget(
        question: question,
        questionOptions: qOption,
      );
    case 'Dropdown':
      return DropDwonQuestionWidget(
          question: question, questionOptions: qOption);
    default:
      return Container();
  }
}
