// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class QuestionsOptionDModel extends Equatable {
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

  const QuestionsOptionDModel({
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

  factory QuestionsOptionDModel.fromJson(Map<String, dynamic> json) {
    return QuestionsOptionDModel(
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

  QuestionsOptionDModel copyWith({
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
    return QuestionsOptionDModel(
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

  factory QuestionsOptionDModel.fromMap(Map<dynamic, dynamic> map) {
    return QuestionsOptionDModel(
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

  @override
  // TODO: implement props
  List<Object?> get props => [qodID, oID];
}

class QuestionOptionDDataModel {
  final Map<String, QuestionsOptionDModel> questionOptionsData;

  QuestionOptionDDataModel({required this.questionOptionsData});

  factory QuestionOptionDDataModel.fromJson(Map<String, dynamic> json) {
    Map<String, QuestionsOptionDModel> qo = {};
    json.forEach((key, value) {
      if (key != 'error') {
        qo[key] = QuestionsOptionDModel.fromJson(value);
      }
    });
    return QuestionOptionDDataModel(questionOptionsData: qo);
  }
}

class QuestionsOptionsDataAdapter extends TypeAdapter<QuestionsOptionDModel> {
  @override
  final int typeId = 3;

  @override
  QuestionsOptionDModel read(BinaryReader reader) {
    return QuestionsOptionDModel(
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
  void write(BinaryWriter writer, QuestionsOptionDModel obj) {
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
