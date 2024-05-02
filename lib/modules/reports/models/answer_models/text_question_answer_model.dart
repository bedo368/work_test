import 'package:flutter_application_1/modules/reports/models/answer_models/question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:hive/hive.dart';

class TextQuestionAnswerModel extends QuestionAnswerModel {
  TextQuestionAnswerModel({
    required this.answer,
    required super.question,
    required super.pStageId,
  });

  final String answer;

  @override
  String toString() {
    return 'TextQuestionAnswerModel(answer: $answer, question: $question, pStageId: $pStageId)';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'answer': answer,
      'question': question.toMap(),
      'pStageId': pStageId,
    };
  }

  static TextQuestionAnswerModel fromMap(Map<String, dynamic> map) {
    return TextQuestionAnswerModel(
      answer: map['answer'],
      question: QuestionModel.fromMap(map['question']),
      pStageId: map['pStageId'],
    );
  }

  TextQuestionAnswerModel copyWith({
    String? answer,
    QuestionModel? question,
    String? pStageId,
  }) {
    return TextQuestionAnswerModel(
      answer: answer ?? this.answer,
      question: question ?? this.question,
      pStageId: pStageId ?? this.pStageId,
    );
  }
}

class TextQuestionAnswerModelAdapter
    extends TypeAdapter<TextQuestionAnswerModel> {
  @override
  final int typeId = 9;

  @override
  TextQuestionAnswerModel read(BinaryReader reader) {
    final answer = reader.read();
    final question = QuestionModel.fromMap(reader.read());
    final pStageId = reader.read();

    return TextQuestionAnswerModel(
      answer: answer,
      question: question,
      pStageId: pStageId,
    );
  }

  @override
  void write(BinaryWriter writer, TextQuestionAnswerModel obj) {
    writer.write(obj.answer);
    writer.write(obj.question.toMap());
    writer.write(obj.pStageId);
  }
}
