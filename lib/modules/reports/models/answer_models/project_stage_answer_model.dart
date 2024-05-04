import 'package:flutter_application_1/modules/reports/models/answer_models/question_answer_model.dart';
import 'package:hive/hive.dart';

class ProjectStageAnswerModel {
  final String pStageId;
  final List<QuestionAnswerModel> questionAnswers;

  ProjectStageAnswerModel({
    required this.pStageId,
    required this.questionAnswers,
  });

  Map<String, dynamic> toMap() {
    return {
      'pStageId': pStageId,
      'questionAnswers': questionAnswers.map((qa) => qa.toMap()).toList(),
    };
  }

  static ProjectStageAnswerModel fromMap(Map<String, dynamic> map) {
    return ProjectStageAnswerModel(
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

  static ProjectStageAnswerModel fromString(String str) {
    // Implement parsing logic if required
    throw UnimplementedError('fromString method is not implemented');
  }

  ProjectStageAnswerModel copyWith({
    String? pStageId,
    List<QuestionAnswerModel>? questionAnswers,
  }) {
    return ProjectStageAnswerModel(
      pStageId: pStageId ?? this.pStageId,
      questionAnswers: questionAnswers ?? this.questionAnswers,
    );
  }

  Future<void> storeInHive() async {
    var box = Hive.box<ProjectStageAnswerModel>('projectStageAnswers');
    box.put(pStageId, this);
  }

  Future<ProjectStageAnswerModel?> getFormHive() async {
    var box = Hive.box<ProjectStageAnswerModel>('projectStageAnswers');
    return box.get(pStageId);
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

    return ProjectStageAnswerModel(
      pStageId: pStageId,
      questionAnswers: questionAnswers.cast<QuestionAnswerModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProjectStageAnswerModel obj) {
    writer.writeString(obj.pStageId);
    writer.writeList(obj.questionAnswers);
  }
}
