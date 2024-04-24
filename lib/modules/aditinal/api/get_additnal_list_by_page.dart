import 'dart:convert';

import 'package:flutter_application_1/modules/aditinal/models/aditnal_list_model.dart';
import 'package:flutter_application_1/core/common/error_model.dart';
import 'package:http/http.dart' as http;

class GetAdinalListApi {
  Future<dynamic> getAdinalList({required int page, String? ref}) async {
    final body = {
      "PerToken": "5745de6308cd01eb30531bd8613aec81",
      "PerUserID": 37,
      "PerRoleID": 185,
      "Page": page,
      "ReferenceNo": ref ?? ''
    };
    final headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.post(
          Uri.parse(
            'https://test.cpvarabia.com/api/Inspection_App/AVQuotationList.php',
          ),
          body: jsonEncode(body),
          headers: headers);

      final Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200 && !data['error']) {
        return AVQuotationList.fromJson(data);
      } else {
        return ErrorModel(errorMessage: data['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
