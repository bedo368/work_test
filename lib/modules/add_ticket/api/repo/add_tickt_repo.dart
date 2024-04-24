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
}
