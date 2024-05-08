import 'dart:developer';

import 'package:flutter_application_1/modules/reports/models/answer_models/checkbox_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/dropdwon_question_anser_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/file_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/image_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/ins_check_list_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/observation_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/radio_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/text_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/user_select_question_answer_model.dart';
import 'package:hive/hive.dart';

class ProjectStageAnswerModel {
  final String pStageId;
  final List<QuestionAnswerModel> questionAnswers;
  final String sectionId;

  ProjectStageAnswerModel(
      {required this.pStageId,
      required this.questionAnswers,
      required this.sectionId});

  Map<String, dynamic> toMap() {
    return {
      'pStageId': pStageId,
      'questionAnswers': questionAnswers.map((qa) => qa.toMap()).toList(),
      'sectionId': sectionId
    };
  }

  static ProjectStageAnswerModel fromMap(Map<String, dynamic> map) {
    return ProjectStageAnswerModel(
        pStageId: map['pStageId'],
        questionAnswers: List<QuestionAnswerModel>.from(
          map['questionAnswers']
              .map((qaMap) => QuestionAnswerModel.fromMap(qaMap)),
        ),
        sectionId: map['sectionId']);
  }

  @override
  String toString() {
    return 'ProjectStageAnserModel(pStageId: $pStageId, questionAnswers: $questionAnswers , sectionId:$sectionId)';
  }

  static ProjectStageAnswerModel fromString(String str) {
    // Implement parsing logic if required
    throw UnimplementedError('fromString method is not implemented');
  }

  ProjectStageAnswerModel copyWith({
    String? pStageId,
    List<QuestionAnswerModel>? questionAnswers,
    String? sectionId,
  }) {
    return ProjectStageAnswerModel(
        pStageId: pStageId ?? this.pStageId,
        questionAnswers: questionAnswers ?? this.questionAnswers,
        sectionId: sectionId ?? this.sectionId);
  }

  Future<void> storeInHive() async {
    var box = Hive.box<ProjectStageAnswerModel>('projectStageAnswers');
    box.add(this);
  }

  Future<ProjectStageAnswerModel?> getFormHive() async {
    var box = Hive.box<ProjectStageAnswerModel>('projectStageAnswers');
    return box.values.firstWhere((element) => element.sectionId == sectionId);
  }

  void printconvertToRequest() {
    log('staart');
    for (var qa in questionAnswers) {
      log(' ${qa.question.answerType}  qid :${qa.question.qID}  ');

      if (qa is CheckboxQuestionAnswerModel) {
        log('option :${qa.questionOptions} ');
      }

      if (qa is TextQuestionAnswerModel) {
        log('answer :${qa.answer} ');
      }
      if (qa is RadioQuestionAnswerModel) {
        log('answer :${qa.questionOption} ');
      }

      if (qa is ImageQuestionAnswerModel) {
        log('answer :${qa.questionOptions} ');
      }
      if (qa is FileQuestionAnswerModel) {
        log('answer :${qa.questionOption} ');
      }
      if (qa is DropDownQuestionAnswerModel) {
        log('answer :${qa.questionOption} ');
      }
      if (qa is UserSelectQuestionAnswerModel) {
        log('questionOption  :${qa.questionOption}  , qustionOptionData : ${qa.questionOptionData}');
      }
      if (qa is InsCheckListQuestionAnswerModel) {
        log('questionOption  :${qa.questionOption}  ');
      }

      if (qa is ObservationQuestionAnswerModel) {
        log(' qoption   :${qa.questionOption}   , qoptionData : ${qa.questionOptionData}');
      }
      log('----------------------------question end----------------------------');
    }
    log('---------------------------------------------------section  end---------------------------------------------------------');
  }
}

class ProjectStageAnserModelAdapter
    extends TypeAdapter<ProjectStageAnswerModel> {
  @override
  final int typeId = 8;

  @override
  ProjectStageAnswerModel read(BinaryReader reader) {
    var pStageId = reader.readString();
    var questionAnswers = reader.readList();
    var sectionId = reader.readString();

    return ProjectStageAnswerModel(
      pStageId: pStageId,
      questionAnswers: questionAnswers.cast<QuestionAnswerModel>(),
      sectionId: sectionId,
    );
  }

  @override
  void write(BinaryWriter writer, ProjectStageAnswerModel obj) {
    writer.writeString(obj.pStageId);
    writer.writeList(obj.questionAnswers);
    writer.writeString(obj.sectionId);
  }
}
