import 'dart:convert';

import 'package:hive/hive.dart';

class QuestionAnswerModel {
  final String qOID;
  final String qID;
  final dynamic answer;
  final dynamic imagesCounter;
  final String defaultValue;
  final String active;
  final String deleted;

  QuestionAnswerModel({
    required this.qOID,
    required this.qID,
    required this.answer,
    required this.imagesCounter,
    required this.defaultValue,
    required this.active,
    required this.deleted,
  });

  factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) {
    return QuestionAnswerModel(
      qOID: json['QOID'] ?? '',
      qID: json['QID'] ?? '',
      answer: json['Answer'],
      imagesCounter: json['ImagesCounter'],
      defaultValue: json['DefaultValue'],
      active: json['Active'],
      deleted: json['Deleted'],
    );
  }

  QuestionAnswerModel copyWith({
    String? qOID,
    String? qID,
    dynamic answer,
    dynamic imagesCounter,
    String? defaultValue,
    String? active,
    String? deleted,
  }) {
    return QuestionAnswerModel(
      qOID: qOID ?? this.qOID,
      qID: qID ?? this.qID,
      answer: answer ?? this.answer,
      imagesCounter: imagesCounter ?? this.imagesCounter,
      defaultValue: defaultValue ?? this.defaultValue,
      active: active ?? this.active,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qOID': qOID,
      'qID': qID,
      'answer': answer,
      'imagesCounter': imagesCounter,
      'defaultValue': defaultValue,
      'active': active,
      'deleted': deleted,
    };
  }

  factory QuestionAnswerModel.fromMap(Map<String, dynamic> map) {
    return QuestionAnswerModel(
      qOID: map['qOID'] as String,
      qID: map['qID'] as String,
      answer: map['answer'] as dynamic,
      imagesCounter: map['imagesCounter'] as dynamic,
      defaultValue: map['defaultValue'] as String,
      active: map['active'] as String,
      deleted: map['deleted'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}

class QuestionsDataModel {
  final Map<String, QuestionAnswerModel> questionsAnswers;

  QuestionsDataModel({required this.questionsAnswers});

  factory QuestionsDataModel.fromJson(Map<String, dynamic> json) {
    Map<String, QuestionAnswerModel> qA = {};
    json.forEach((key, value) {
      if (key != 'error') {
        qA[key] = QuestionAnswerModel.fromJson(value);
      }
    });
    return QuestionsDataModel(questionsAnswers: qA);
  }
}

class QutionDataAdaptor extends TypeAdapter<QuestionAnswerModel> {
  @override
  QuestionAnswerModel read(BinaryReader reader) {
    return QuestionAnswerModel(
        qOID: reader.read(),
        qID: reader.read(),
        answer: reader.read(),
        imagesCounter: reader.read(),
        defaultValue: reader.read(),
        active: reader.read(),
        deleted: reader.read());
  }

  @override
  int get typeId => 4;

  @override
  void write(BinaryWriter writer, QuestionAnswerModel obj) {
    writer.write(obj.qOID);
    writer.write(obj.qID);
    writer.write(obj.answer);
    writer.write(obj.imagesCounter);
    writer.write(obj.defaultValue);
    writer.write(obj.active);
    writer.write(obj.deleted);
  }
}