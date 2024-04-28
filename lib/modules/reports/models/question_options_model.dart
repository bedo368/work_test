// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:hive/hive.dart';

class QuestionsOptionsModel {
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

  QuestionsOptionsModel({
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

  factory QuestionsOptionsModel.fromJson(Map<String, dynamic> json) {
    return QuestionsOptionsModel(
      qodID: json['QODID'],
      oID: json['OID'],
      qData: json['QData'],
      degreeID: json['DegreeID'],
      degreeName: json['DegreeName'],
      transferTo: json['TransferTo'],
      transferName: json['TransferName'],
      commentEN: json['CommentEN'],
      commentAR: json['CommentAR'],
      correctiveEN: json['CorrectiveEN'],
      correctiveAR: json['CorrectiveAR'],
    );
  }

  QuestionsOptionsModel copyWith({
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
    return QuestionsOptionsModel(
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

  factory QuestionsOptionsModel.fromMap(Map<String, dynamic> map) {
    return QuestionsOptionsModel(
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

class SectionsDataModel {
  final Map<String, QuestionsOptionsModel> questionOptions;

  SectionsDataModel({required this.questionOptions});

  factory SectionsDataModel.fromJson(Map<String, dynamic> json) {
    Map<String, QuestionsOptionsModel> qo = {};
    json.forEach((key, value) {
      if (key != 'error') {
        qo[key] = QuestionsOptionsModel.fromJson(value);
      }
    });
    return SectionsDataModel(questionOptions: qo);
  }
}

class QuestionsOptionsModelAdapter extends TypeAdapter<QuestionsOptionsModel> {
  @override
  final int typeId = 3;

  @override
  QuestionsOptionsModel read(BinaryReader reader) {
    return QuestionsOptionsModel(
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
  void write(BinaryWriter writer, QuestionsOptionsModel obj) {
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
