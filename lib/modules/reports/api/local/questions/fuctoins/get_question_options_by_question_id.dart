import 'package:flutter_application_1/modules/reports/api/server/fetch_all_api/fetch_all.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';
import 'package:hive/hive.dart';

Future<dynamic> getQuestionOptoinByQuestionIdFunc(
    {required String questionId}) async {
  try {
    if (Hive.isBoxOpen(hiveQuestionBox)) {
      final questionBox = Hive.box<QuestionOptionsModel>(hiveQuestionOptionBox);

      return questionBox.values
          .where((element) => element.qID == questionId)
          .toList();
    } else {
      final questionBox =
          await Hive.openBox<QuestionOptionsModel>(hiveQuestionOptionBox);
      return questionBox.values
          .where((element) => element.qID == questionId)
          .toList();
    }
  } catch (e) {
    rethrow;
  }
}
