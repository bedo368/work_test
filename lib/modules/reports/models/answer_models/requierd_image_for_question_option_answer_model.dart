import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';
import 'package:hive/hive.dart';

class RequierdImageAnswerForQuetionOptionModel {
  RequierdImageAnswerForQuetionOptionModel({
    required this.imagePathsList,
    required this.questionOption,
    required this.question,
  });

  final QuestionOptionsModel questionOption;
  final List<String> imagePathsList;
  final QuestionModel question;

  @override
  String toString() {
    return 'RequierdImageForQuetionOptionModel(questionOption: $questionOption, question: $question,imagePathsList : $imagePathsList )';
  }

  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePathsList,
      'questionOption': questionOption,
      'question': question.toMap(),
    };
  }

  static RequierdImageAnswerForQuetionOptionModel fromMap(
      Map<String, dynamic> map) {
    return RequierdImageAnswerForQuetionOptionModel(
      imagePathsList: map['imagePath'],
      questionOption: map['questionOption'],
      question: QuestionModel.fromMap(map['question']),
    );
  }
}

class RequierdImageAnswerForQuetionOptionModelAdapter
    extends TypeAdapter<RequierdImageAnswerForQuetionOptionModel> {
  @override
  final int typeId = 220;

  @override
  RequierdImageAnswerForQuetionOptionModel read(BinaryReader reader) {
    final answer = reader.readList();
    final optionId = reader.read();
    final question = QuestionModel.fromMap(reader.read());

    return RequierdImageAnswerForQuetionOptionModel(
      imagePathsList: answer.cast(),
      questionOption: optionId,
      question: question,
    );
  }

  @override
  void write(
      BinaryWriter writer, RequierdImageAnswerForQuetionOptionModel obj) {
    writer.writeList(obj.imagePathsList);
    writer.write(obj.questionOption);
    writer.write(obj.question.toMap());
  }
}
