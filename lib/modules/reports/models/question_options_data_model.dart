// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:hive/hive.dart';

class QuestionsOptionsDataModel {
  final String qodID;
  final String oID;
  final dynamic qData;
  final String degreeID;
  final String degreeName;
  final dynamic transferTo;
  final dynamic transferName;
  final dynamic commentEN;
  final dynamic commentAR;
  final dynamic correctiveEN;
  final dynamic correctiveAR;

  QuestionsOptionsDataModel({
    required this.qodID,
    required this.oID,
    required this.qData,
    required this.degreeID,
    required this.degreeName,
    required this.transferTo,
    required this.transferName,
    required this.commentEN,
    required this.commentAR,
    required this.correctiveEN,
    required this.correctiveAR,
  });

  factory QuestionsOptionsDataModel.fromJson(Map<String, dynamic> json) {
    return QuestionsOptionsDataModel(
      qodID: json['QODID'] ?? '',
      oID: json['OID'] ?? '',
      qData: json['QData'] ?? '',
      degreeID: json['DegreeID'] ?? '',
      degreeName: json['DegreeName'] ?? '',
      transferTo: json['TransferTo'] ?? '',
      transferName: json['TransferName'] ?? '',
      commentEN: json['CommentEN'] ?? '',
      commentAR: json['CommentAR'] ?? '',
      correctiveEN: json['CorrectiveEN'] ?? '',
      correctiveAR: json['CorrectiveAR'] ?? '',
    );
  }

  QuestionsOptionsDataModel copyWith({
    String? qodID,
    String? oID,
    dynamic qData,
    String? degreeID,
    String? degreeName,
    dynamic transferTo,
    dynamic transferName,
    dynamic commentEN,
    dynamic commentAR,
    dynamic correctiveEN,
    dynamic correctiveAR,
  }) {
    return QuestionsOptionsDataModel(
      qodID: qodID ?? this.qodID,
      oID: oID ?? this.oID,
      qData: qData ?? this.qData,
      degreeID: degreeID ?? this.degreeID,
      degreeName: degreeName ?? this.degreeName,
      transferTo: transferTo ?? this.transferTo,
      transferName: transferName ?? this.transferName,
      commentEN: commentEN ?? this.commentEN,
      commentAR: commentAR ?? this.commentAR,
      correctiveEN: correctiveEN ?? this.correctiveEN,
      correctiveAR: correctiveAR ?? this.correctiveAR,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qodID': qodID,
      'oID': oID,
      'qData': qData,
      'degreeID': degreeID,
      'degreeName': degreeName,
      'transferTo': transferTo,
      'transferName': transferName,
      'commentEN': commentEN,
      'commentAR': commentAR,
      'correctiveEN': correctiveEN,
      'correctiveAR': correctiveAR,
    };
  }

  factory QuestionsOptionsDataModel.fromMap(Map<String, dynamic> map) {
    return QuestionsOptionsDataModel(
      qodID: map['qodID'] as String,
      oID: map['oID'] as String,
      qData: map['qData'],
      degreeID: map['degreeID'] as String,
      degreeName: map['degreeName'] as String,
      transferTo: map['transferTo'],
      transferName: map['transferName'],
      commentEN: map['commentEN'],
      commentAR: map['commentAR'],
      correctiveEN: map['correctiveEN'],
      correctiveAR: map['correctiveAR'],
    );
  }

  String toJson() {
    return json.encode(toMap());
  }
}

class QuestionOptionDataDataModel {
  final Map<String, QuestionsOptionsDataModel> questionOptions;

  QuestionOptionDataDataModel({required this.questionOptions});

  factory QuestionOptionDataDataModel.fromJson(Map<String, dynamic> json) {
    Map<String, QuestionsOptionsDataModel> qo = {};
    json.forEach((key, value) {
      if (key != 'error') {
        qo[key] = QuestionsOptionsDataModel.fromJson(value);
      }
    });
    return QuestionOptionDataDataModel(questionOptions: qo);
  }
}

class QuestionsOptionsModelAdapter
    extends TypeAdapter<QuestionsOptionsDataModel> {
  @override
  final int typeId = 3;

  @override
  QuestionsOptionsDataModel read(BinaryReader reader) {
    return QuestionsOptionsDataModel(
      qodID: reader.read(),
      oID: reader.read(),
      qData: reader.read(),
      degreeID: reader.read(),
      degreeName: reader.read(),
      transferTo: reader.read(),
      transferName: reader.read(),
      commentEN: reader.read(),
      commentAR: reader.read(),
      correctiveEN: reader.read(),
      correctiveAR: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, QuestionsOptionsDataModel obj) {
    writer.write(obj.qodID);
    writer.write(obj.oID);
    writer.write(obj.qData);
    writer.write(obj.degreeID);
    writer.write(obj.degreeName);
    writer.write(obj.transferTo);
    writer.write(obj.transferName);
    writer.write(obj.commentEN);
    writer.write(obj.commentAR);
    writer.write(obj.correctiveEN);
    writer.write(obj.correctiveAR);
  }
}
