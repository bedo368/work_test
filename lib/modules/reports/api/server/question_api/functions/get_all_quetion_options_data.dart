import 'dart:convert';

import 'package:flutter_application_1/core/common/error_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_data_model.dart';
import 'package:http/http.dart' as http;

Future<dynamic> getAllQuestionOptionDataFunc() async {
  try {
    final uri = Uri.parse(
        'https://test.cpvarabia.com/api/Inspection_App/download_questions_options_data.php');
    final body = {
      "PerToken": "5745de6308cd01eb30531bd8613aec81",
      "PerUserID": 37,
      "PerRoleID": 185
    };
    final headers = {
      'Content-Type': 'application/json',
    };

    final response =
        await http.post(uri, headers: headers, body: jsonEncode(body));

    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && !data['error']) {
      return QuestionOptionDDataModel.fromJson(data);
    } else if (data['error']) {
      return ErrorModel(errorMessage: data["message"]);
    } else {
      return ErrorModel(errorMessage: 'error!');
    }
  } catch (e) {
    return ErrorModel(errorMessage: 'error!');
  }
}
