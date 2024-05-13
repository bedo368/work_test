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

class PStageSectionAnswerModel {
  final String pStageId;
  final List<QuestionAnswerModel> questionAnswers;
  final String sectionId;

  PStageSectionAnswerModel(
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

  List<Map<String, dynamic>> getQuestionOptionWithReqiredImage() {
    final List<Map<String, dynamic>> questionAnswersList = [];

    for (var qa in questionAnswers) {
      if (qa is ObservationQuestionAnswerModel) {
        for (var qo in qa.questionOption) {
          if (qo.imagesCounter != null &&
              qo.imagesCounter != '0' &&
              qo.imagesCounter != 0) {
            questionAnswersList.add({
              'question': qa.question,
              'questionOptionId': qo.qOID,
              'imageReqiredCount': qo.imagesCounter
            });
          }
        }
      }
      if (qa is UserSelectQuestionAnswerModel) {
        if (qa.questionOption.imagesCounter != null &&
            qa.questionOption.imagesCounter != '0' &&
            qa.questionOption.imagesCounter != 0) {
          questionAnswersList.add({
            'question': qa.question,
            'questionOptionId': qa.questionOption.qOID,
            'imageReqiredCount': qa.questionOption.imagesCounter
          });
        }
      }
      if (qa is InsCheckListQuestionAnswerModel) {
        if (qa.questionOption.imagesCounter != null &&
            qa.questionOption.imagesCounter != '0' &&
            qa.questionOption.imagesCounter != 0) {
          questionAnswersList.add({
            'question': qa.question,
            'questionOptionId': qa.questionOption.qOID,
            'imageReqiredCount': qa.questionOption.imagesCounter
          });
        }
      }
    }
    return questionAnswersList;
  }

  static PStageSectionAnswerModel fromMap(Map<String, dynamic> map) {
    return PStageSectionAnswerModel(
        pStageId: map['pStageId'],
        questionAnswers: List<QuestionAnswerModel>.from(
          map['questionAnswers']
              .map((qaMap) => QuestionAnswerModel.fromMap(qaMap)),
        ),
        sectionId: map['sectionId']);
  }

  @override
  String toString() {
    return 'PStageSectionAnswerModel(pStageId: $pStageId, questionAnswers: $questionAnswers , sectionId:$sectionId)';
  }

  static PStageSectionAnswerModel fromString(String str) {
    // Implement parsing logic if required
    throw UnimplementedError('fromString method is not implemented');
  }

  PStageSectionAnswerModel copyWith({
    String? pStageId,
    List<QuestionAnswerModel>? questionAnswers,
    String? sectionId,
  }) {
    return PStageSectionAnswerModel(
        pStageId: pStageId ?? this.pStageId,
        questionAnswers: questionAnswers ?? this.questionAnswers,
        sectionId: sectionId ?? this.sectionId);
  }

  Future<void> storeInHive() async {
    var box = Hive.box<PStageSectionAnswerModel>('projectStageAnswers');
    box.add(this);
  }

  Future<PStageSectionAnswerModel?> getFormHive() async {
    var box = Hive.box<PStageSectionAnswerModel>('projectStageAnswers');
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

class PStageSectionAnswerModelAdapter
    extends TypeAdapter<PStageSectionAnswerModel> {
  @override
  final int typeId = 8;

  @override
  PStageSectionAnswerModel read(BinaryReader reader) {
    var pStageId = reader.readString();
    var questionAnswers = reader.readList();
    var sectionId = reader.readString();

    return PStageSectionAnswerModel(
      pStageId: pStageId,
      questionAnswers: questionAnswers.cast<QuestionAnswerModel>(),
      sectionId: sectionId,
    );
  }

  @override
  void write(BinaryWriter writer, PStageSectionAnswerModel obj) {
    writer.writeString(obj.pStageId);
    writer.writeList(obj.questionAnswers);
    writer.writeString(obj.sectionId);
  }
}
