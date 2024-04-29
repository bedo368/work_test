// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

class SectionModel {
  final String sectionID;
  final String sectionType;
  final String sectionOrder;
  final String sectionName;
  final String stageID;
  final String? ptype;
  final String deleted;
  final String? lastUpdate;
  final String special;

  SectionModel({
    required this.sectionID,
    required this.sectionType,
    required this.sectionOrder,
    required this.sectionName,
    required this.stageID,
    this.ptype,
    required this.deleted,
    this.lastUpdate,
    required this.special,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      sectionID: json['SectionID'] ?? '',
      sectionType: json['SectionType'] ?? '',
      sectionOrder: json['SectionOrder'] ?? '',
      sectionName: json['SectionName'] ?? '',
      stageID: json['StageID'] ?? '',
      ptype: json['Ptype'] ?? '',
      deleted: json['Deleted'] ?? '',
      lastUpdate: json['LastUpdate'] ?? '',
      special: json['Special'] ?? '',
    );
  }

  SectionModel copyWith({
    String? sectionID,
    String? sectionType,
    String? sectionOrder,
    String? sectionName,
    String? stageID,
    String? ptype,
    String? deleted,
    String? lastUpdate,
    String? special,
  }) {
    return SectionModel(
      sectionID: sectionID ?? this.sectionID,
      sectionType: sectionType ?? this.sectionType,
      sectionOrder: sectionOrder ?? this.sectionOrder,
      sectionName: sectionName ?? this.sectionName,
      stageID: stageID ?? this.stageID,
      ptype: ptype ?? this.ptype,
      deleted: deleted ?? this.deleted,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      special: special ?? this.special,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sectionID': sectionID,
      'sectionType': sectionType,
      'sectionOrder': sectionOrder,
      'sectionName': sectionName,
      'stageID': stageID,
      'ptype': ptype,
      'deleted': deleted,
      'lastUpdate': lastUpdate,
      'special': special,
    };
  }

  factory SectionModel.fromMap(Map<String, dynamic> map) {
    return SectionModel(
      sectionID: map['sectionID'] as String,
      sectionType: map['sectionType'] as String,
      sectionOrder: map['sectionOrder'] as String,
      sectionName: map['sectionName'] as String,
      stageID: map['stageID'] as String,
      ptype: map['ptype'] != null ? map['ptype'] as String : null,
      deleted: map['deleted'] as String,
      lastUpdate:
          map['lastUpdate'] != null ? map['lastUpdate'] as String : null,
      special: map['special'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}

class SectionsDataModel {
  final Map<String, SectionModel> sections;

  SectionsDataModel({required this.sections});

  factory SectionsDataModel.fromJson(Map<String, dynamic> json) {
    Map<String, SectionModel> section = {};
    json.forEach((key, value) {
      if (key != 'error') {
        section[key] = SectionModel.fromJson(value);
      }
    });
    return SectionsDataModel(sections: section);
  }
}

class SectionModelHiveAdapter extends TypeAdapter<SectionModel> {
  @override
  SectionModel read(BinaryReader reader) {
    return SectionModel(
      sectionID: reader.read(),
      sectionType: reader.read(),
      sectionOrder: reader.read(),
      sectionName: reader.read(),
      stageID: reader.read(),
      ptype: reader.read(),
      deleted: reader.read(),
      lastUpdate: reader.read(),
      special: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, SectionModel obj) {
    writer.write(obj.sectionID);
    writer.write(obj.sectionType);
    writer.write(obj.sectionOrder);
    writer.write(obj.sectionName);
    writer.write(obj.stageID);
    writer.write(obj.ptype);
    writer.write(obj.deleted);
    writer.write(obj.lastUpdate);
    writer.write(obj.special);
  }

  @override
  int get typeId => 1;
}
