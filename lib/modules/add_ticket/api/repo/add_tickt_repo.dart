import 'package:flutter_application_1/modules/add_ticket/api/functions/add_ticket_with_degree.dart';
import 'package:flutter_application_1/modules/add_ticket/api/functions/add_tickt_with_transfer_id.dart';
import 'package:flutter_application_1/modules/add_ticket/api/functions/get_degree_list.dart';
import 'package:flutter_application_1/modules/add_ticket/api/functions/get_refnom_list.dart';

class AddTicktRepo {
  Future<dynamic> getRefNomList() => getRefNomListFunc();
  Future<dynamic> getDegreeList() => getDegreeListFunc();
  Future<dynamic> addTeicketWithTransferId(
          {required String disc,
          required String refNom,
          required String transferIdType}) =>
      addTicketWithTransferIdFunc(
          refNom: refNom, disc: disc, transferIdType: transferIdType);

  Future<dynamic> addTicketWithDegree({
    required String refNom,
    required degreeId,
    required String disc,
    required commentAr,
    String correctiveAr = '',
    String correctiveEn = '',
  }) =>
      addTicketWithDegreeFunc(
          refNom: refNom,
          disc: disc,
          commentAr: commentAr,
          correctiveAr: correctiveAr,
          correctiveEn: correctiveEn,
          degreeId: degreeId);
}
