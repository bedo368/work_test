import 'dart:convert';

import 'package:flutter_application_1/core/common/error_model.dart';
import 'package:flutter_application_1/modules/reports/models/project_stage_response_model.dart';
import 'package:http/http.dart' as http;

Future<dynamic> getProjectStageId(
    {required String location,
    required String projectNom,
    required String stageId}) async {
  try {
    final body = {
      "PerToken": "5745de6308cd01eb30531bd8613aec81",
      "PerUserID": "37",
      "PerRoleID": "185",
      "Location": location,
      "ReferenceNo": projectNom,
      "StageID": stageId
    };
    final uri = Uri.parse(
        'https://test.cpvarabia.com/api/Inspection_App/New_Inspection.php');
    final headers = {
      'Content-Type': 'application/json',
    };

    final response =
        await http.post(uri, headers: headers, body: jsonEncode(body));
    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && !data['error']) {
      return StageResponse.fromJson(data);
    } else if (data['error']) {
      return ErrorModel(errorMessage: data["message"]);
    } else {
      return ErrorModel(errorMessage: 'error!');
    }
  } catch (e) {
    return ErrorModel(errorMessage: 'there is an error');
  }
}
