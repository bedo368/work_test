import 'package:flutter_application_1/modules/reports/models/answer_models/question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';
import 'package:hive/hive.dart';

class DropDownQuestionAnswerModel extends QuestionAnswerModel {
  final QuestionOptionsModel questionOptions;

  DropDownQuestionAnswerModel({
    required this.questionOptions,
    required super.question,
    required super.pStageId,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'questionOptions': questionOptions.toMap(),
      'question': question.toMap(),
      'pStageId': pStageId,
    };
  }

  static DropDownQuestionAnswerModel fromMap(Map<String, dynamic> map) {
    return DropDownQuestionAnswerModel(
      questionOptions: QuestionOptionsModel.fromMap(map['questionOptions']),
      question: QuestionModel.fromMap(map['question']),
      pStageId: map['pStageId'],
    );
  }

  DropDownQuestionAnswerModel copyWith({
    QuestionOptionsModel? questionOptions,
    QuestionModel? question,
    String? pStageId,
  }) {
    return DropDownQuestionAnswerModel(
      questionOptions: questionOptions ?? this.questionOptions,
      question: question ?? this.question,
      pStageId: pStageId ?? this.pStageId,
    );
  }

  @override
  String toString() {
    return 'DropDownQuestionAnswerModel(questionOptions: $questionOptions, question: $question, pStageId: $pStageId)';
  }
}

class DropDownQuestionAnswerModelAdapter
    extends TypeAdapter<DropDownQuestionAnswerModel> {
  @override
  final int typeId = 10;

  @override
  DropDownQuestionAnswerModel read(BinaryReader reader) {
    var questionOptions = reader.read();
    var question = reader.read();
    var pStageId = reader.read();

    return DropDownQuestionAnswerModel(
      questionOptions: questionOptions,
      question: question,
      pStageId: pStageId,
    );
  }

  @override
  void write(BinaryWriter writer, DropDownQuestionAnswerModel obj) {
    writer.write<QuestionOptionsModel>(obj.questionOptions);
    writer.write<QuestionModel>(obj.question);
    writer.write(obj.pStageId);
  }
}
