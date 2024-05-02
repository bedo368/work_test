import 'package:flutter_application_1/modules/reports/models/answer_models/checkbox_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/radio_question_answer_model.dart';
import 'package:hive/hive.dart';

class ProjectStageAnserModel {
  final String pStageId;
  final List<QuestionAnswerModel> questionAnswers;

  ProjectStageAnserModel({
    required this.pStageId,
    required this.questionAnswers,
  });

  Map<String, dynamic> toMap() {
    return {
      'pStageId': pStageId,
      'questionAnswers': questionAnswers.map((qa) => qa.toMap()).toList(),
    };
  }

  static ProjectStageAnserModel fromMap(Map<String, dynamic> map) {
    return ProjectStageAnserModel(
      pStageId: map['pStageId'],
      questionAnswers: List<QuestionAnswerModel>.from(
        map['questionAnswers']
            .map((qaMap) => QuestionAnswerModel.fromMap(qaMap)),
      ),
    );
  }

  @override
  String toString() {
    return 'ProjectStageAnserModel(pStageId: $pStageId, questionAnswers: $questionAnswers)';
  }

  static ProjectStageAnserModel fromString(String str) {
    // Implement parsing logic if required
    throw UnimplementedError('fromString method is not implemented');
  }

  ProjectStageAnserModel copyWith({
    String? pStageId,
    List<QuestionAnswerModel>? questionAnswers,
  }) {
    return ProjectStageAnserModel(
      pStageId: pStageId ?? this.pStageId,
      questionAnswers: questionAnswers ?? this.questionAnswers,
    );
  }

  Future<void> storeInHive() async {
    var box = await Hive.openBox<ProjectStageAnserModel>('projectStageAnswers');
    box.put(pStageId, this);
  }

  Future<ProjectStageAnserModel?> getFormHive() async {
    var box = await Hive.openBox<ProjectStageAnserModel>('projectStageAnswers');
    return box.get(pStageId);
  }
}

class ProjectStageAnserModelAdapter
    extends TypeAdapter<ProjectStageAnserModel> {
  @override
  final int typeId = 8;

  @override
  ProjectStageAnserModel read(BinaryReader reader) {
    var pStageId = reader.readString();
    var questionAnswersLength = reader.readByte();
    var questionAnswers = <QuestionAnswerModel>[];

    for (var i = 0; i < questionAnswersLength; i++) {
      var typeId = reader.readByte();
      switch (typeId) {
        case 6:
          questionAnswers
              .add(CheckboxQuestionAnswerModelAdapter().read(reader));
          break;
        case 7:
          questionAnswers.add(RadioQuestionAnswerModelAdapter().read(reader));
          break;
        default:
          throw Exception('Unknown type ID $typeId');
      }
    }

    return ProjectStageAnserModel(
        pStageId: pStageId, questionAnswers: questionAnswers);
  }

  @override
  void write(BinaryWriter writer, ProjectStageAnserModel obj) {
    writer.writeString(obj.pStageId);
    writer.writeByte(obj.questionAnswers.length);
    for (var qa in obj.questionAnswers) {
      if (qa is CheckboxQuestionAnswerModel) {
        writer.writeByte(2);
        CheckboxQuestionAnswerModelAdapter().write(writer, qa);
      } else if (qa is RadioQuestionAnswerModel) {
        writer.writeByte(3);
        RadioQuestionAnswerModelAdapter().write(writer, qa);
      } else {
        throw Exception('Unsupported type: ${qa.runtimeType}');
      }
    }
  }
}
