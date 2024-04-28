// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

class QuestionModel {
  final String qID;
  final String questionOrder;
  final String sectionID;
  final String qTitle;
  final String? qHint;
  final String? qHelp;
  final String answerType;
  final String active;
  final String rd6;
  final String createdAt;
  final String deleted;
  final String? tiCode;
  final String required;

  QuestionModel({
    required this.qID,
    required this.questionOrder,
    required this.sectionID,
    required this.qTitle,
    this.qHint,
    this.qHelp,
    required this.answerType,
    required this.active,
    required this.rd6,
    required this.createdAt,
    required this.deleted,
    this.tiCode,
    required this.required,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      qID: json['QID'],
      questionOrder: json['QuestionOrder'],
      sectionID: json['SectionID'],
      qTitle: json['QTitle'],
      qHint: json['QHint'],
      qHelp: json['QHelp'],
      answerType: json['AnswerType'],
      active: json['Active'],
      rd6: json['RD6'],
      createdAt: json['CreatedAt'],
      deleted: json['Deleted'],
      tiCode: json['TICode'],
      required: json['Required'],
    );
  }

  QuestionModel copyWith({
    String? qID,
    String? questionOrder,
    String? sectionID,
    String? qTitle,
    String? qHint,
    String? qHelp,
    String? answerType,
    String? active,
    String? rd6,
    String? createdAt,
    String? deleted,
    String? tiCode,
    String? required,
  }) {
    return QuestionModel(
      qID: qID ?? this.qID,
      questionOrder: questionOrder ?? this.questionOrder,
      sectionID: sectionID ?? this.sectionID,
      qTitle: qTitle ?? this.qTitle,
      qHint: qHint ?? this.qHint,
      qHelp: qHelp ?? this.qHelp,
      answerType: answerType ?? this.answerType,
      active: active ?? this.active,
      rd6: rd6 ?? this.rd6,
      createdAt: createdAt ?? this.createdAt,
      deleted: deleted ?? this.deleted,
      tiCode: tiCode ?? this.tiCode,
      required: required ?? this.required,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qID': qID,
      'questionOrder': questionOrder,
      'sectionID': sectionID,
      'qTitle': qTitle,
      'qHint': qHint,
      'qHelp': qHelp,
      'answerType': answerType,
      'active': active,
      'rd6': rd6,
      'createdAt': createdAt,
      'deleted': deleted,
      'tiCode': tiCode,
      'required': required,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      qID: map['qID'] as String,
      questionOrder: map['questionOrder'] as String,
      sectionID: map['sectionID'] as String,
      qTitle: map['qTitle'] as String,
      qHint: map['qHint'] != null ? map['qHint'] as String : null,
      qHelp: map['qHelp'] != null ? map['qHelp'] as String : null,
      answerType: map['answerType'] as String,
      active: map['active'] as String,
      rd6: map['rd6'] as String,
      createdAt: map['createdAt'] as String,
      deleted: map['deleted'] as String,
      tiCode: map['tiCode'] != null ? map['tiCode'] as String : null,
      required: map['required'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}

class QuestionsDataModel {
  final Map<String, QuestionModel> questions;

  QuestionsDataModel({required this.questions});

  factory QuestionsDataModel.fromJson(Map<String, dynamic> json) {
    Map<String, QuestionModel> q = {};
    json.forEach((key, value) {
      if (key != 'error') {
        q[key] = QuestionModel.fromJson(value);
      }
    });
    return QuestionsDataModel(questions: q);
  }
}

class QuestionHiveAdaptor extends TypeAdapter<QuestionModel> {
  @override
  read(BinaryReader reader) {
    return QuestionModel(
        qID: reader.read(),
        questionOrder: reader.read(),
        sectionID: reader.read(),
        qTitle: reader.read(),
        answerType: reader.read(),
        active: reader.read(),
        rd6: reader.read(),
        createdAt: reader.read(),
        deleted: reader.read(),
        required: reader.read());
  }

  @override
  int get typeId => 2;

  @override
  void write(BinaryWriter writer, obj) {
    writer.write(obj.qID);
    writer.write(obj.questionOrder);
    writer.write(obj.sectionID);
    writer.write(obj.qTitle);
    writer.write(obj.answerType);
    writer.write(obj.active);
    writer.write(obj.rd6);
    writer.write(obj.createdAt);
    writer.write(obj.deleted);
    writer.write(obj.required);
  }
}
