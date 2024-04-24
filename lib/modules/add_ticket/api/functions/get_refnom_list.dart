import 'dart:convert';

import 'package:flutter_application_1/core/common/error_model.dart';
import 'package:flutter_application_1/modules/add_ticket/models/transfer_to_model.dart';
import 'package:http/http.dart' as http;

Future<dynamic> getRefNomListFunc() async {
  final body = {
    "PerToken": "5745de6308cd01eb30531bd8613aec81",
    "PerUserID": 37,
    "PerRoleID": 185
  };

  final headers = {'Content-Type': 'application/json'};

  try {
    final res = await http.post(
        Uri.parse(
            'https://test.cpvarabia.com/api/inspection/TransferToList.php'),
        headers: headers,
        body: jsonEncode(body));

    final data = jsonDecode(res.body);
    if (res.statusCode == 200 && !data['error']) {
      return TransferToListModel.fromJson(data);
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
