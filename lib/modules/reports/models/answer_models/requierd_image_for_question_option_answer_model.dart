import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:hive/hive.dart';

class RequierdImageAnswerForQuetionOptionModel {
  RequierdImageAnswerForQuetionOptionModel({
    required this.imagePath,
    required this.questionOptionid,
    required this.question,
  });

  final String questionOptionid;
  final String imagePath;
  final QuestionModel question;

  @override
  String toString() {
    return 'RequierdImageForQuetionOptionModel(questionOption: $questionOptionid, question: $question,)';
  }

  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'questionOption': questionOptionid,
      'question': question.toMap(),
    };
  }

  static RequierdImageAnswerForQuetionOptionModel fromMap(
      Map<String, dynamic> map) {
    return RequierdImageAnswerForQuetionOptionModel(
      imagePath: map['imagePath'],
      questionOptionid: map['questionOptionId'],
      question: QuestionModel.fromMap(map['question']),
    );
  }

  RequierdImageAnswerForQuetionOptionModel copyWith({
    String? answer,
    QuestionModel? question,
  }) {
    return RequierdImageAnswerForQuetionOptionModel(
      imagePath: imagePath,
      questionOptionid: answer ?? questionOptionid,
      question: question ?? this.question,
    );
  }
}

class RequierdImageAnswerForQuetionOptionModelAdapter
    extends TypeAdapter<RequierdImageAnswerForQuetionOptionModel> {
  @override
  final int typeId = 220;

  @override
  RequierdImageAnswerForQuetionOptionModel read(BinaryReader reader) {
    final answer = reader.read();
    final optionId = reader.read();
    final question = QuestionModel.fromMap(reader.read());

    return RequierdImageAnswerForQuetionOptionModel(
      imagePath: answer,
      questionOptionid: optionId,
      question: question,
    );
  }

  @override
  void write(
      BinaryWriter writer, RequierdImageAnswerForQuetionOptionModel obj) {
    writer.write(obj.imagePath);
    writer.write(obj.questionOptionid);
    writer.write(obj.question.toMap());
  }
}
