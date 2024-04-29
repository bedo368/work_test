import 'package:flutter_application_1/modules/reports/api/server/fetch_all_api/fetch_all.dart';
import 'package:flutter_application_1/modules/reports/models/section_model.dart';
import 'package:hive/hive.dart';

Future<dynamic> getSectionsByStageIdFunc({required String stageId}) async {
  try {
    if (Hive.isBoxOpen(hiveSectionBox)) {
      final sectionsBox = Hive.box<SectionModel>(hiveSectionBox);

      return sectionsBox.values
          .where((element) => element.stageID == stageId)
          .toList();
    } else {
      final sectionsBox = await Hive.openBox<SectionModel>(hiveSectionBox);
      return sectionsBox.values
          .where((element) => element.stageID == stageId)
          .toList();
    }
  } catch (e) {
    rethrow;
  }
}
