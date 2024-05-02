import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/check_box_question.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/ins_check_list_question.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/drop_dwon_question.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/file_question.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/image_question_widget.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/observation_question.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/radio_question.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/text_question.dart';
import 'package:flutter_application_1/modules/reports/views/widgets/user_select_question.dart';

Widget selectQuestionByType(
    {required QuestionModel question,
    required List<QuestionOptionsModel> qOption,
    required Function(dynamic quetionInfo) onSelected}) {
  switch (question.answerType) {
    case 'InsChecklist':
      return InsCheckListQuestionWidget(
        key: ValueKey(question.qID),
        question: question,
        questionOptions: qOption,
        onSelected: onSelected,
      );
    case 'Dropdown':
      return DropDwonQuestionWidget(
        key: ValueKey(question.qID),
        question: question,
        questionOptions: qOption,
        onSelected: onSelected,
      );
    case 'Radio':
      return RadioQuestionWidget(
        key: ValueKey(question.qID),
        question: question,
        questionOptions: qOption,
        onSelected: onSelected,
      );
    case 'CheckBox':
      return CheckBoxQuestionWidget(
        key: ValueKey(question.qID),
        question: question,
        questionOptions: qOption,
        onSelected: onSelected,
      );
    case 'Text':
      return TextQuestionWidget(
        key: ValueKey(question.qID),
        question: question,
        onSelected: onSelected,
      );
    case 'TextArea':
      return TextQuestionWidget(
        key: ValueKey(question.qID),
        question: question,
        onSelected: onSelected,
      );
    case 'File':
      return FileQuestionWidget(
        key: ValueKey(question.qID),
        question: question,
        questionOptions: qOption,
        onSelected: onSelected,
      );
    case 'UserSelect':
      return UserSelectQuestionWidget(
        key: ValueKey(question.qID),
        question: question,
        questionOptions: qOption,
        onSelected: onSelected,
      );
    case 'Observation':
      return ObesrvationQuestionWidget(
        key: ValueKey(question.qID),
        question: question,
        questionOptions: qOption,
        onSelected: onSelected,
      );

    case 'Image':
      return ImageQuestionWidget(
        question: question,
        questionOptions: qOption,
        onSelected: onSelected,
      );
    default:
      return Container();
  }
}
