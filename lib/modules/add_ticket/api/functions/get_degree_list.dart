import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_application_1/core/common/error_model.dart';
import 'package:flutter_application_1/modules/add_ticket/models/degree_model.dart';

Future<dynamic> getDegreeListFunc() async {
  final body = {
    "PerToken": "5745de6308cd01eb30531bd8613aec81",
    "PerUserID": 37,
    "PerRoleID": 185,
    "Category": "Design"
  };

  final headers = {'Content-Type': 'application/json'};

  try {
    final res = await http.post(
        Uri.parse('https://test.cpvarabia.com/api/inspection/DegreeList.php'),
        headers: headers,
        body: jsonEncode(body));

    final data = jsonDecode(res.body);
    if (res.statusCode == 200 && !data['error']) {
      return DegreeListModel.fromJson(data);
    } else if (data['error']) {
      return ErrorModel(errorMessage: data['message']);
    } else {
      return ErrorModel(
          errorMessage: 'something wrong happend please try again later');
    }
  } catch (e) {
    rethrow;
  }
}
