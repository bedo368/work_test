import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/modules/aditinal/models/add_ticket_model.dart';
import 'package:flutter_application_1/core/common/error_model.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:http/http.dart' as http;

class AddTicketApi {
  Future<dynamic> addTicket(
      {required String refNom, required BuildContext context}) async {
    final body = {
      "PerToken": "5745de6308cd01eb30531bd8613aec81",
      "PerUserID": 37,
      "PerRoleID": 185,
      "TransferTo": "",
      "DegreeID": "11",
      "Description": "test desc",
      "CommentAR": "sss",
      "CorrectiveEN": "",
      "CorrectiveAR": "ss",
      "ReferenceNo": refNom
    };
    final headers = {'Content-Type': 'application/json'};

    try {
      Loader.show(context);
      final response = await http.post(
          Uri.parse(
            'https://test.cpvarabia.com/api/Inspection_App/AddTicket.php',
          ),
          body: jsonEncode(body),
          headers: headers);

      Loader.hide();

      final Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200 && !data['error']) {
        return AddTicketSuccessModel(
            message: data['message'], error: data['error']);
      } else {
        return ErrorModel(errorMessage: data['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
