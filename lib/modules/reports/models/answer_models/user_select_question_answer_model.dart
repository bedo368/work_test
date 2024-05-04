import 'package:flutter_application_1/modules/reports/models/answer_models/question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_data_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';
import 'package:hive/hive.dart';

class UserSelectQuestionAnswerModel extends QuestionAnswerModel {
  UserSelectQuestionAnswerModel({
    required this.questionOption,
    required super.question,
    required super.pStageId,
    required this.questionOptionData,
  });

  final QuestionOptionsModel questionOption;
  final QuestionsOptionDModel questionOptionData;

  @override
  Map<String, dynamic> toMap() {
    return {
      'questionOption': questionOption.toMap(),
      'question': question.toMap(),
      'pStageId': pStageId,
      'questionOptionData': questionOptionData.toMap(),
    };
  }

  static UserSelectQuestionAnswerModel fromMap(Map<dynamic, dynamic> map) {
    return UserSelectQuestionAnswerModel(
      questionOption: QuestionOptionsModel.fromMap(map['questionOption']),
      question: QuestionModel.fromMap(map['question']),
      pStageId: map['pStageId'],
      questionOptionData: map['questionOptionData'], //
    );
  }

  UserSelectQuestionAnswerModel copyWith({
    QuestionOptionsModel? questionOption,
    QuestionModel? question,
  }) {
    return UserSelectQuestionAnswerModel(
        questionOption: questionOption ?? this.questionOption,
        question: question ?? this.question,
        pStageId: pStageId,
        questionOptionData: questionOptionData);
  }

  @override
  String toString() {
    return 'RadioQuestionAnswerModel(questionOption: $questionOption, question: $question, pStageId: $pStageId)';
  }
}

class UserSelectQuestionAnswerModelAdapter
    extends TypeAdapter<UserSelectQuestionAnswerModel> {
  @override
  final int typeId = 14;

  @override
  UserSelectQuestionAnswerModel read(BinaryReader reader) {
    var questionOption = QuestionOptionsModel.fromMap(reader.read());
    var question = QuestionModel.fromMap(reader.read());
    var pStageId = reader.read();
    var questionOptionData = QuestionsOptionDModel.fromMap(reader.read());

    return UserSelectQuestionAnswerModel(
      questionOption: questionOption,
      question: question,
      pStageId: pStageId,
      questionOptionData: questionOptionData,
    );
  }

  @override
  void write(BinaryWriter writer, UserSelectQuestionAnswerModel obj) {
    writer.write(obj.questionOption.toMap());
    writer.write(obj.question.toMap());
    writer.write(obj.pStageId);
    writer.write(obj.questionOptionData.toMap());
  }
}
