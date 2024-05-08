import 'package:flutter_application_1/modules/reports/models/answer_models/question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';
import 'package:hive/hive.dart';

class InsCheckListQuestionAnswerModel extends QuestionAnswerModel {
  InsCheckListQuestionAnswerModel({
    required this.questionOption,
    required super.question,
    required super.pStageId,
  });

  final QuestionOptionsModel questionOption;

  @override
  Map<String, dynamic> toMap() {
    return {
      'questionOption': questionOption.toMap(),
      'question': question.toMap(),
    };
  }

  static InsCheckListQuestionAnswerModel fromMap(Map<String, dynamic> map) {
    return InsCheckListQuestionAnswerModel(
      questionOption: QuestionOptionsModel.fromMap(map['questionOption']),
      question: QuestionModel.fromMap(map['question']),
      pStageId: map['pStageId'], //
    );
  }

  InsCheckListQuestionAnswerModel copyWith({
    QuestionOptionsModel? questionOption,
    QuestionModel? question,
  }) {
    return InsCheckListQuestionAnswerModel(
      questionOption: questionOption ?? this.questionOption,
      question: question ?? this.question,
      pStageId: pStageId,
    );
  }

  @override
  String toString() {
    return 'InsCheckListQuestionAnswerModel(questionOption: $questionOption, question: $question, pStageId: $pStageId)';
  }
}

class InsCheckListQuestionAnswerModelAdapter
    extends TypeAdapter<InsCheckListQuestionAnswerModel> {
  @override
  final int typeId = 11;

  @override
  InsCheckListQuestionAnswerModel read(BinaryReader reader) {
    var questionOption = QuestionOptionsModel.fromMap(reader.read());
    var question = QuestionModel.fromMap(reader.read());
    var pStageId = reader.read();

    return InsCheckListQuestionAnswerModel(
      questionOption: questionOption,
      question: question,
      pStageId: pStageId,
    );
  }

  @override
  void write(BinaryWriter writer, InsCheckListQuestionAnswerModel obj) {
    writer.write(obj.questionOption.toMap());
    writer.write(obj.question.toMap());
    writer.write(obj.pStageId);
  }
}
