import 'package:flutter_application_1/modules/reports/api/question_api/functions/get_all_questions.dart';
import 'package:flutter_application_1/modules/reports/api/question_api/functions/get_all_guestion_options.dart';

class QuestionApiRepo {
  Future<dynamic> getAllQuestion() => getAllQuestionsFunc();
  Future<dynamic> getAllQuestionOptions() => getAllQuestionsOptionsFunc();
}
