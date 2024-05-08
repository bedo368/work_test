import 'package:flutter_application_1/modules/reports/models/answer_models/question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:hive/hive.dart';

class ImageQuestionAnswerModel extends QuestionAnswerModel {
  ImageQuestionAnswerModel({
    required this.questionOptions,
    required super.question,
    required super.pStageId,
  });

  final List<String> questionOptions;

  @override
  String toString() {
    return 'ImageQuestionAnswerModel(questionOption: $questionOptions, question: $question, pStageId: $pStageId)';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'questionOption': questionOptions,
      'question': question.toMap(),
      'pStageId': pStageId,
    };
  }

  static ImageQuestionAnswerModel fromMap(Map<String, dynamic> map) {
    return ImageQuestionAnswerModel(
      questionOptions: map['answer'],
      question: QuestionModel.fromMap(map['question']),
      pStageId: map['pStageId'],
    );
  }

  ImageQuestionAnswerModel copyWith({
    List<String>? answer,
    QuestionModel? question,
    String? pStageId,
  }) {
    return ImageQuestionAnswerModel(
      questionOptions: answer ?? questionOptions,
      question: question ?? this.question,
      pStageId: pStageId ?? this.pStageId,
    );
  }
}

class ImageQuestionAnswerModelAdapter
    extends TypeAdapter<ImageQuestionAnswerModel> {
  @override
  final int typeId = 13;

  @override
  ImageQuestionAnswerModel read(BinaryReader reader) {
    final answer = reader.read();
    final question = QuestionModel.fromMap(reader.read());
    final pStageId = reader.read();

    return ImageQuestionAnswerModel(
      questionOptions: answer,
      question: question,
      pStageId: pStageId,
    );
  }

  @override
  void write(BinaryWriter writer, ImageQuestionAnswerModel obj) {
    writer.write(obj.questionOptions);
    writer.write(obj.question.toMap());
    writer.write(obj.pStageId);
  }
}
