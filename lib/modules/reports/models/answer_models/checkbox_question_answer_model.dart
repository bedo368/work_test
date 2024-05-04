import 'package:flutter_application_1/modules/reports/models/answer_models/question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';
import 'package:hive/hive.dart';

class CheckboxQuestionAnswerModel extends QuestionAnswerModel {
  CheckboxQuestionAnswerModel({
    required this.questionOptions,
    required super.question,
    required super.pStageId,
  });

  final List<QuestionOptionsModel> questionOptions;

  @override
  Map<String, dynamic> toMap() {
    return {
      'questionOptions':
          questionOptions.map((option) => option.toMap()).toList(),
      'question': question.toMap(), // Assuming question has toMap method
    };
  }

  static CheckboxQuestionAnswerModel fromMap(Map<String, dynamic> map) {
    return CheckboxQuestionAnswerModel(
      questionOptions: List<QuestionOptionsModel>.from(
          (map['questionOptions'] as List<dynamic>).map((optionMap) =>
              QuestionOptionsModel.fromMap(optionMap as Map<String, dynamic>))),
      question: QuestionModel.fromMap(map['question']),
      pStageId: map['pStageId'],
    );
  }

  @override
  String toString() {
    return 'CheckboxQuestionAnswerModel(questionOptions: $questionOptions, question: $question)';
  }

  CheckboxQuestionAnswerModel copyWith({
    List<QuestionOptionsModel>? questionOptions,
    QuestionModel? question,
  }) {
    return CheckboxQuestionAnswerModel(
      questionOptions: questionOptions ?? this.questionOptions,
      question: question ?? this.question,
      pStageId: pStageId,
    );
  }
}

class CheckboxQuestionAnswerModelAdapter
    extends TypeAdapter<CheckboxQuestionAnswerModel> {
  @override
  final int typeId = 6;

  @override
  CheckboxQuestionAnswerModel read(BinaryReader reader) {
    var questionOptions = (reader.read() as List<dynamic>)
        .map((item) => QuestionOptionsModel.fromMap(item))
        .toList();
    var question = QuestionModel.fromMap(reader.read());
    var pStageId = reader.read();

    return CheckboxQuestionAnswerModel(
      questionOptions: questionOptions.cast<QuestionOptionsModel>(),
      question: question,
      pStageId: pStageId,
    );
  }

  @override
  void write(BinaryWriter writer, CheckboxQuestionAnswerModel obj) {
    writer.write(obj.questionOptions.map((item) => item.toMap()).toList());
    writer.write<Map<String, dynamic>>(obj.question.toMap());
    writer.write(obj.pStageId);
  }
}
