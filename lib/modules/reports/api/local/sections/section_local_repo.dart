import 'package:flutter_application_1/modules/reports/api/local/sections/functions/get_sections_by_stage_id.dart';

class SectionLocalRepo {
  Future<dynamic> getSectionsByStageId({required String stageId}) =>
      getSectionsByStageIdFunc(stageId: stageId);
}
