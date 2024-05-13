import 'dart:developer';

import 'package:flutter_application_1/modules/reports/models/answer_models/project_stage_section_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/requierd_image_for_question_option_answer_model.dart';

import 'package:hive/hive.dart';

class PStageAnswerModel {
  final String pStageId;
  final List<PStageSectionAnswerModel> pStageSectionsAnswers;
  final List<Map<String, dynamic>> imageRequiredForStageSections;
  List<RequierdImageAnswerForQuetionOptionModel>
      imageRequiredForStageSectionAnswer;

  PStageAnswerModel({
    required this.pStageId,
    required this.pStageSectionsAnswers,
    required this.imageRequiredForStageSections,
    required this.imageRequiredForStageSectionAnswer,
  });

  Map<String, dynamic> toMap() {
    return {
      'pStageId': pStageId,
      'pStageSectionsAnswers':
          pStageSectionsAnswers.map((qa) => qa.toMap()).toList(),
    };
  }

  static PStageAnswerModel fromMap(Map<String, dynamic> map) {
    return PStageAnswerModel(
        pStageId: map['pStageId'],
        pStageSectionsAnswers: map['pStageSectionsAnswers'],
        imageRequiredForStageSections: [],
        imageRequiredForStageSectionAnswer: []);
  }

  factory PStageAnswerModel.createWithImageRequired(
      {required List<PStageSectionAnswerModel> sectionsAnswers}) {
    List<Map<String, dynamic>> tImageRequired = [];

    for (var se in sectionsAnswers) {
      final l = se.getQuestionOptionWithReqiredImage();

      tImageRequired.addAll(l);
    }
    return PStageAnswerModel(
      pStageId: sectionsAnswers.first.pStageId,
      pStageSectionsAnswers: sectionsAnswers,
      imageRequiredForStageSections: tImageRequired,
      imageRequiredForStageSectionAnswer: [],
    );
  }

  int getImageRequiredCount() {
    int n = 0;
    for (var i in imageRequiredForStageSections) {
      n += int.parse(i['imageReqiredCount']);
    }
    log(n.toString());
    return n;
  }

  @override
  String toString() {
    return 'ProjectStageAnserModel(pStageId: $pStageId, questionAnswers: $pStageSectionsAnswers ,imageRequiredForStageSection:  $imageRequiredForStageSections ,imageRequiredForStageSectionAnswer: $imageRequiredForStageSectionAnswer)';
  }

  static PStageAnswerModel fromString(String str) {
    throw UnimplementedError('fromString method is not implemented');
  }

  PStageAnswerModel copyWith({
    String? pStageId,
    List<PStageSectionAnswerModel>? questionAnswers,
    String? sectionId,
  }) {
    return PStageAnswerModel(
      pStageId: pStageId ?? this.pStageId,
      pStageSectionsAnswers: questionAnswers ?? pStageSectionsAnswers,
      imageRequiredForStageSections: imageRequiredForStageSections,
      imageRequiredForStageSectionAnswer: imageRequiredForStageSectionAnswer,
    );
  }

  // Future<PStageAnswerModel?> getFormHive() async {
  //   var box = Hive.box<PStageAnswerModel>('projectStageAnswers');
  //   return box.values.firstWhere((element) => element.sectionId == sectionId);
  // }
}

class ProjectStageAnserModelAdapter extends TypeAdapter<PStageAnswerModel> {
  @override
  final int typeId = 55;

  @override
  PStageAnswerModel read(BinaryReader reader) {
    var pStageId = reader.readString();
    var questionAnswers = reader.readList();
    var imageRequiredForStageSection1 = reader.readList();
    var imageRequiredForStageSectionAnswer1 = reader.readList();

    return PStageAnswerModel(
      pStageId: pStageId,
      pStageSectionsAnswers: questionAnswers.cast<PStageSectionAnswerModel>(),
      imageRequiredForStageSections: imageRequiredForStageSection1.cast(),
      imageRequiredForStageSectionAnswer:
          imageRequiredForStageSectionAnswer1.cast(),
    );
  }

  @override
  void write(BinaryWriter writer, PStageAnswerModel obj) {
    writer.writeString(obj.pStageId);
    writer.writeList(obj.pStageSectionsAnswers);
    writer.writeList(obj.imageRequiredForStageSections);
    writer.writeList(obj.imageRequiredForStageSectionAnswer);
  }
}
