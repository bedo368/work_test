import 'package:flutter_application_1/modules/reports/api/server/fetch_all_api/fetch_all.dart';
import 'package:flutter_application_1/modules/reports/models/stage_models.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<dynamic> fetchAllStagesFromHiveFunc() async {
  try {
    if (Hive.isBoxOpen(hiveStageBox)) {
      final _stageBox = Hive.box<StageModel>(hiveStageBox);

      return _stageBox.values.toList();
    } else {
      final _stageBox = await Hive.openBox<StageModel>(hiveStageBox);
      return _stageBox.values.toList();
    }
  } catch (e) {
    rethrow;
  }
}
