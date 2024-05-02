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

  // Future<void> storeInHive() async {
  //   var box = await Hive.openBox<CheckboxQuestionAnswerModel>(
  //       'checkboxQuestionAnswers');
  //   box.add(this);
  // }

  // Future<CheckboxQuestionAnswerModel> getFormHive() async {
  //   var box = await Hive.openBox<CheckboxQuestionAnswerModel>(
  //       'checkboxQuestionAnswers');
  //   return box.values.firstWhere((element) => element == this);
  // }
}

class CheckboxQuestionAnswerModelAdapter
    extends TypeAdapter<CheckboxQuestionAnswerModel> {
  @override
  final int typeId = 6;

  @override
  CheckboxQuestionAnswerModel read(BinaryReader reader) {
    var questionOptionsLength = reader.readByte();
    var questionOptions = <QuestionOptionsModel>[];
    for (var i = 0; i < questionOptionsLength; i++) {
      questionOptions.add(QuestionOptionsModel.fromMap(reader.readMap()));
    }

    var question = QuestionModel.fromMap(reader.read());
    var pStageId = reader.read();

    return CheckboxQuestionAnswerModel(
      questionOptions: questionOptions,
      question: question,
      pStageId: pStageId,
    );
  }

  @override
  void write(BinaryWriter writer, CheckboxQuestionAnswerModel obj) {
    writer.writeByte(obj.questionOptions.length);
    for (var option in obj.questionOptions) {
      writer.writeMap(option.toMap());
    }

    writer.write(obj.question.toMap());
    writer.write(obj.pStageId);
  }
}
