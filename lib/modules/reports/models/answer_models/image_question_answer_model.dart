import 'package:flutter_application_1/modules/reports/models/answer_models/question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:hive/hive.dart';

class ImageQuestionAnswerModel extends QuestionAnswerModel {
  ImageQuestionAnswerModel({
    required this.questionOption,
    required super.question,
    required super.pStageId,
  });

  final List<String> questionOption;

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

  static ImageQuestionAnswerModel fromMap(Map<String, dynamic> map) {
    return ImageQuestionAnswerModel(
      questionOption: map['answer'],
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
      questionOption: answer ?? questionOption,
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
      questionOption: answer,
      question: question,
      pStageId: pStageId,
    );
  }

  @override
  void write(BinaryWriter writer, ImageQuestionAnswerModel obj) {
    writer.write(obj.questionOption);
    writer.write(obj.question.toMap());
    writer.write(obj.pStageId);
  }
}
