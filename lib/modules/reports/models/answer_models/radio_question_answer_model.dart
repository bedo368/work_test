import 'package:flutter_application_1/modules/reports/models/answer_models/question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';
import 'package:hive/hive.dart';

class RadioQuestionAnswerModel extends QuestionAnswerModel {
  RadioQuestionAnswerModel({
    required this.questionOption,
    required super.question,
    required super.pStageId,
  });

  final QuestionOptionsModel questionOption;

  Map<String, dynamic> toMap() {
    return {
      'questionOption': questionOption.toMap(),
      'question': question.toMap(),
    };
  }

  static RadioQuestionAnswerModel fromMap(Map<String, dynamic> map) {
    return RadioQuestionAnswerModel(
      questionOption: QuestionOptionsModel.fromMap(map['questionOption']),
      question: QuestionModel.fromMap(map['question']),
      pStageId: map['pStageId'], //
    );
  }

  RadioQuestionAnswerModel copyWith({
    QuestionOptionsModel? questionOption,
    QuestionModel? question,
  }) {
    return RadioQuestionAnswerModel(
      questionOption: questionOption ?? this.questionOption,
      question: question ?? this.question,
      pStageId: pStageId,
    );
  }

  @override
  String toString() {
    return 'RadioQuestionAnswerModel(questionOption: $questionOption, question: $question, pStageId: $pStageId)';
  }
}

class RadioQuestionAnswerModelAdapter
    extends TypeAdapter<RadioQuestionAnswerModel> {
  @override
  final int typeId = 6;

  @override
  RadioQuestionAnswerModel read(BinaryReader reader) {
    var questionOption = QuestionOptionsModel.fromMap(reader.read());
    var question = QuestionModel.fromMap(reader.read());
    var pStageId = reader.read();

    return RadioQuestionAnswerModel(
      questionOption: questionOption,
      question: question,
      pStageId: pStageId,
    );
  }

  @override
  void write(BinaryWriter writer, RadioQuestionAnswerModel obj) {
    writer.write(obj.questionOption.toMap());
    writer.write(obj.question.toMap());
    writer.write(obj.pStageId);
  }
}
