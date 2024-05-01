import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/check_box_question.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/check_list_question.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/drop_dwon_question.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/file_question.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/image_question_widget.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/observation_question.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/radio_question.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/text_question.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/user_select_question.dart';

Widget selectQuestionByType(
    {required QuestionModel question,
    required List<QuestionOptionsModel> qOption}) {
  switch (question.answerType) {
    case 'InsChecklist':
      return CheckListQuestionWidget(
        key: ValueKey(question.qID),
        question: question,
        questionOptions: qOption,
      );
    case 'Dropdown':
      return DropDwonQuestionWidget(
          key: ValueKey(question.qID),
          question: question,
          questionOptions: qOption);
    case 'Radio':
      return RadioQuestionWidget(
          key: ValueKey(question.qID),
          question: question,
          questionOptions: qOption);
    case 'CheckBox':
      return CheckBoxQuestionWidget(
          key: ValueKey(question.qID),
          question: question,
          questionOptions: qOption);
    case 'Text':
      return TextQuestionWidget(
        key: ValueKey(question.qID),
        question: question,
      );
    case 'TextArea':
      return TextQuestionWidget(
        key: ValueKey(question.qID),
        question: question,
      );
    case 'File':
      return FileQuestionWidget(
          key: ValueKey(question.qID),
          question: question,
          questionOptions: qOption);
    case 'UserSelect':
      return UserSelectQuestionWidget(
          key: ValueKey(question.qID),
          question: question,
          questionOptions: qOption);
    case 'Observation':
      return ObesrvationQuestionWidget(
          key: ValueKey(question.qID),
          question: question,
          questionOptions: qOption);

    case 'Image':
      return ImageQuestionWidget(question: question, questionOptions: qOption);
    default:
      return Container();
  }
}
