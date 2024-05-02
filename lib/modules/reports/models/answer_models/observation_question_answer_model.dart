import 'package:flutter_application_1/modules/reports/models/answer_models/question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_data_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';
import 'package:hive/hive.dart';

class ObservationQuestionAnswerModel extends QuestionAnswerModel {
  ObservationQuestionAnswerModel({
    required this.questionOption,
    required super.question,
    required super.pStageId,
    required this.questionOptionData,
  });

  final List<QuestionOptionsModel> questionOption;
  final List<QuestionsOptionDModel> questionOptionData;

  @override
  Map<String, dynamic> toMap() {
    return {
      'questionOption': questionOption.map((e) => e.toMap()).toList(),
      'question': question.toMap(),
      'pStageId': pStageId,
      'questionOptionData': questionOptionData.map((e) => e.toMap()).toList(),
    };
  }

  static ObservationQuestionAnswerModel fromMap(Map<String, dynamic> map) {
    return ObservationQuestionAnswerModel(
      questionOption: map['answer']['questionOption'],
      question: QuestionModel.fromMap(map['question']),
      pStageId: map['pStageId'],
      questionOptionData: map['answer']['questionOptionData'], //
    );
  }

  ObservationQuestionAnswerModel copyWith({
    List<QuestionOptionsModel>? questionOption,
    List<QuestionsOptionDModel>? questionOptionData,
    QuestionModel? question,
  }) {
    return ObservationQuestionAnswerModel(
        questionOption: questionOption ?? this.questionOption,
        question: question ?? this.question,
        pStageId: pStageId,
        questionOptionData: questionOptionData ?? this.questionOptionData);
  }

  @override
  String toString() {
    return 'RadioQuestionAnswerModel(questionOption: $questionOption, question: $question, pStageId: $pStageId)';
  }
}

class ObservationQuestionAnswerModelAdapter
    extends TypeAdapter<ObservationQuestionAnswerModel> {
  @override
  final int typeId = 15;

  @override
  ObservationQuestionAnswerModel read(BinaryReader reader) {
    var questionOption = (reader.read() as List<dynamic>)
        .map((item) => QuestionOptionsModel.fromMap(item))
        .toList();
    var question = QuestionModel.fromMap(reader.read());
    var pStageId = reader.read();
    var questionOptionData = (reader.read() as List<dynamic>)
        .map((item) => QuestionsOptionDModel.fromMap(item))
        .toList();
    return ObservationQuestionAnswerModel(
      questionOption: questionOption,
      question: question,
      pStageId: pStageId,
      questionOptionData: questionOptionData,
    );
  }

  @override
  void write(BinaryWriter writer, ObservationQuestionAnswerModel obj) {
    writer.write(obj.questionOption.map((item) => item.toMap()).toList());
    writer.write(obj.question.toMap());
    writer.write(obj.pStageId);
    writer.write(obj.questionOptionData.map((item) => item.toMap()).toList());
  }
}
