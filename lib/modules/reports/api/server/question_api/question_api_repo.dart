import 'package:flutter_application_1/modules/reports/api/server/question_api/functions/get_all_questions.dart';
import 'package:flutter_application_1/modules/reports/api/server/question_api/functions/get_all_guestion_options.dart';
import 'package:flutter_application_1/modules/reports/api/server/question_api/functions/get_all_quetion_options_data.dart';

class QuestionApiRepo {
  Future<dynamic> getAllQuestion() => getAllQuestionsFunc();
  Future<dynamic> getAllQuestionOptions() => getAllQuestionsOptionsFunc();
  Future<dynamic> getAllQuestionOptionsData() => getAllQuestionOptionDataFunc();
}
