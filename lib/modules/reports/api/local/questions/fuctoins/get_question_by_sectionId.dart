import 'package:flutter_application_1/modules/reports/api/server/fetch_all_api/fetch_all.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:hive/hive.dart';

Future<dynamic> getQuestionBySectionIdFunc({required String sectionId}) async {
  try {
    if (Hive.isBoxOpen(hiveQuestionBox)) {
      final questionBox = Hive.box<QuestionModel>(hiveQuestionBox);

      return questionBox.values
          .where((element) => element.sectionID == sectionId)
          .toList();
    } else {
      final questionBox = await Hive.openBox<QuestionModel>(hiveQuestionBox);
      return questionBox.values
          .where((element) => element.sectionID == sectionId)
          .toList();
    }
  } catch (e) {
    rethrow;
  }
}
