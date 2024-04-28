import 'dart:convert';

import 'package:flutter_application_1/core/common/error_model.dart';
import 'package:flutter_application_1/modules/reports/models/stage_models.dart';
import 'package:http/http.dart' as http;

Future<dynamic> getAllStagesFunc() async {
  try {
    final uri =
        Uri.parse('http://test.cpvarabia.com/api/mobile/download_stages.php');

    final body = {};
    final headers = {'Content-Type': 'application/json'};

    final response =
        await http.post(uri, body: jsonEncode(body), headers: headers);

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && !data['error']) {
      return StagesDataModel.fromJson(data);
    } else if (data['error']) {
      return ErrorModel(errorMessage: data["message"]);
    } else {
      return ErrorModel(errorMessage: 'error!');
    }
  } catch (e) {
    return ErrorModel(errorMessage: 'error!');
  }
}
