import 'package:flutter_application_1/modules/reports/models/answer_models/question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:hive/hive.dart';

class FileQuestionAnswerModel extends QuestionAnswerModel {
  FileQuestionAnswerModel({
    required this.questionOption,
    required super.question,
    required super.pStageId,
  });

  final String questionOption;

  @override
  String toString() {
    return 'TextQuestionAnswerModel(answer: $questionOption, question: $question, pStageId: $pStageId)';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'questionOption': questionOption,
      'question': question.toMap(),
      'pStageId': pStageId,
    };
  }

  static FileQuestionAnswerModel fromMap(Map<String, dynamic> map) {
    return FileQuestionAnswerModel(
      questionOption: map['questionOption'],
      question: QuestionModel.fromMap(map['question']),
      pStageId: map['pStageId'],
    );
  }

  FileQuestionAnswerModel copyWith({
    String? answer,
    QuestionModel? question,
    String? pStageId,
  }) {
    return FileQuestionAnswerModel(
      questionOption: answer ?? questionOption,
      question: question ?? this.question,
      pStageId: pStageId ?? this.pStageId,
    );
  }
}

class FileQuestionAnswerModelAdapter
    extends TypeAdapter<FileQuestionAnswerModel> {
  @override
  final int typeId = 12;

  @override
  FileQuestionAnswerModel read(BinaryReader reader) {
    final answer = reader.read();
    final question = QuestionModel.fromMap(reader.read());
    final pStageId = reader.read();

    return FileQuestionAnswerModel(
      questionOption: answer,
      question: question,
      pStageId: pStageId,
    );
  }

  @override
  void write(BinaryWriter writer, FileQuestionAnswerModel obj) {
    writer.write(obj.questionOption);
    writer.write(obj.question.toMap());
    writer.write(obj.pStageId);
  }
}
