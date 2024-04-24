import 'dart:convert';

import 'package:flutter_application_1/core/common/error_model.dart';
import 'package:http/http.dart' as http;

Future<dynamic> addTicketWithTransferIdFunc(
    {required String refNom,
    required String disc,
    required String transferIdType}) async {
  final body = {
    "PerToken": "5745de6308cd01eb30531bd8613aec81",
    "PerUserID": 37,
    "PerRoleID": 185,
    "TransferTo": transferIdType,
    "DegreeID": "11",
    "Description": disc,
    "CommentAR": "sss",
    "CorrectiveEN": "",
    "CorrectiveAR": "ss",
    "ReferenceNo": double.parse(refNom)
  };

  final headers = {'Content-Type': 'application/json'};

  try {
    final res = await http.post(
        Uri.parse(
            'https://test.cpvarabia.com/api/Inspection_App/AddTicket.php'),
        headers: headers,
        body: jsonEncode(body));

    final data = jsonDecode(res.body);
    if (res.statusCode == 200 && !data['error']) {
      print(data);
    } else if (data['error']) {
    } else {
      return ErrorModel(
          errorMessage: 'something wrong happend please try again later');
    }
  } catch (e) {
    rethrow;
  }
}
