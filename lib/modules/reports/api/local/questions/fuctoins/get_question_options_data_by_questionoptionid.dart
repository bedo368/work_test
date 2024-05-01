import 'package:flutter_application_1/modules/reports/api/server/fetch_all_api/fetch_all.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_data_model.dart';
import 'package:hive/hive.dart';

Future<dynamic> getQuestionOptoinDataByQuestionOptionIdFunc(
    {required String questionOptionId}) async {
  try {
    if (Hive.isBoxOpen(hiveQuestionOptionDataBox)) {
      final questionBox =
          Hive.box<QuestionsOptionDModel>(hiveQuestionOptionDataBox);

      return questionBox.values
          .where((element) => element.oID == questionOptionId)
          .toList();
    } else {
      final questionBox =
          await Hive.openBox<QuestionsOptionDModel>(hiveQuestionOptionDataBox);
      return questionBox.values
          .where((element) => element.oID == questionOptionId)
          .toList();
    }
  } catch (e) {
    rethrow;
  }
}
