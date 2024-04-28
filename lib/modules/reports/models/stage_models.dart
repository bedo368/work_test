// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

class StageModel {
  final String stageID;
  final String stageOrder;
  final String category;
  final String stageName;
  final String deleted;
  final String lastUpdate;

  StageModel({
    required this.stageID,
    required this.stageOrder,
    required this.category,
    required this.stageName,
    required this.deleted,
    required this.lastUpdate,
  });

  factory StageModel.fromJson(Map<String, dynamic> json) {
    return StageModel(
      stageID: json['StageID'],
      stageOrder: json['StageOrder'],
      category: json['Category'],
      stageName: json['StageName'],
      deleted: json['Deleted'],
      lastUpdate: json['LastUpdate'],
    );
  }

  StageModel copyWith({
    String? stageID,
    String? stageOrder,
    String? category,
    String? stageName,
    String? deleted,
    String? lastUpdate,
  }) {
    return StageModel(
      stageID: stageID ?? this.stageID,
      stageOrder: stageOrder ?? this.stageOrder,
      category: category ?? this.category,
      stageName: stageName ?? this.stageName,
      deleted: deleted ?? this.deleted,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stageID': stageID,
      'stageOrder': stageOrder,
      'category': category,
      'stageName': stageName,
      'deleted': deleted,
      'lastUpdate': lastUpdate,
    };
  }

  factory StageModel.fromMap(Map<String, dynamic> map) {
    return StageModel(
      stageID: map['stageID'] as String,
      stageOrder: map['stageOrder'] as String,
      category: map['category'] as String,
      stageName: map['stageName'] as String,
      deleted: map['deleted'] as String,
      lastUpdate: map['lastUpdate'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}

class StagesDataModel {
  final Map<String, StageModel> stages;

  StagesDataModel({required this.stages});

  factory StagesDataModel.fromJson(Map<String, dynamic> json) {
    Map<String, StageModel> stages = {};
    json.forEach((key, value) {
      if (key != 'error') {
        stages[key] = StageModel.fromJson(value);
      }
    });
    return StagesDataModel(stages: stages);
  }
}

class StageModelHiveAdaptor extends TypeAdapter<StageModel> {
  @override
  read(BinaryReader reader) {
    return StageModel(
        stageID: reader.read(),
        stageOrder: reader.read(),
        category: reader.read(),
        stageName: reader.read(),
        deleted: reader.read(),
        lastUpdate: reader.read());
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, obj) {
    writer.write(obj.stageID);
    writer.write(obj.stageOrder);
    writer.write(obj.category);
    writer.write(obj.stageName);
    writer.write(obj.deleted);
    writer.write(obj.lastUpdate);
  }
}
