import 'dart:convert';

import 'package:hive/hive.dart';

class QuestionOptionsModel {
  final String qOID;
  final String qID;
  final dynamic answer;
  final dynamic imagesCounter;
  final String defaultValue;
  final String active;
  final String deleted;

  QuestionOptionsModel({
    required this.qOID,
    required this.qID,
    required this.answer,
    required this.imagesCounter,
    required this.defaultValue,
    required this.active,
    required this.deleted,
  });

  factory QuestionOptionsModel.fromJson(Map<String, dynamic> json) {
    return QuestionOptionsModel(
      qOID: json['QOID'] ?? '',
      qID: json['QID'] ?? '',
      answer: json['Answer'] ?? '',
      imagesCounter: json['ImagesCounter'] ?? '0',
      defaultValue: json['DefaultValue'] ?? '',
      active: json['Active'] ?? '',
      deleted: json['Deleted'] ?? '',
    );
  }

  QuestionOptionsModel copyWith({
    String? qOID,
    String? qID,
    dynamic answer,
    dynamic imagesCounter,
    String? defaultValue,
    String? active,
    String? deleted,
  }) {
    return QuestionOptionsModel(
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

  factory QuestionOptionsModel.fromMap(Map<String, dynamic> map) {
    return QuestionOptionsModel(
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

class QuestionsOptionsDataModel {
  final Map<String, QuestionOptionsModel> questionsOptions;

  QuestionsOptionsDataModel({required this.questionsOptions});

  factory QuestionsOptionsDataModel.fromJson(Map<String, dynamic> json) {
    Map<String, QuestionOptionsModel> qA = {};
    json.forEach((key, value) {
      if (key != 'error') {
        qA[key] = QuestionOptionsModel.fromJson(value);
      }
    });
    return QuestionsOptionsDataModel(questionsOptions: qA);
  }
}

class QuestionOptionAdaptor extends TypeAdapter<QuestionOptionsModel> {
  @override
  QuestionOptionsModel read(BinaryReader reader) {
    return QuestionOptionsModel(
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
  void write(BinaryWriter writer, QuestionOptionsModel obj) {
    writer.write(obj.qOID);
    writer.write(obj.qID);
    writer.write(obj.answer);
    writer.write(obj.imagesCounter);
    writer.write(obj.defaultValue);
    writer.write(obj.active);
    writer.write(obj.deleted);
  }
}
