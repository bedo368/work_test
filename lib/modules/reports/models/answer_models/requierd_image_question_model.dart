import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';
import 'package:hive/hive.dart';

class RequiredImageModel {
  RequiredImageModel({
    required this.imageCount,
    required this.questionOption,
    required this.question,
  });

  final QuestionOptionsModel questionOption;
  final int imageCount;
  final QuestionModel question;

  @override
  String toString() {
    return 'RequierdImageForQuetionOptionModel(questionOption: $questionOption, question: $question,)';
  }

  Map<String, dynamic> toMap() {
    return {
      'imageCount': imageCount,
      'questionOption': questionOption,
      'question': question.toMap(),
    };
  }

  static RequiredImageModel fromMap(Map<String, dynamic> map) {
    return RequiredImageModel(
      imageCount: map['imagePath'],
      questionOption: map['questionOptionId'],
      question: QuestionModel.fromMap(map['question']),
    );
  }
}

class RequiredImageModelAdapter extends TypeAdapter<RequiredImageModel> {
  @override
  final int typeId = 221;

  @override
  RequiredImageModel read(BinaryReader reader) {
    final answer = reader.read();
    final optionId = reader.read();
    final question = QuestionModel.fromMap(reader.read());

    return RequiredImageModel(
      imageCount: answer,
      questionOption: optionId,
      question: question,
    );
  }

  @override
  void write(BinaryWriter writer, RequiredImageModel obj) {
    writer.write(obj.imageCount);
    writer.write(obj.questionOption);
    writer.write(obj.question.toMap());
  }
}
