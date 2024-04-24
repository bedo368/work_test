import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/modules/aditinal/api/add_ticket.dart';
import 'package:flutter_application_1/modules/aditinal/api/get_additnal_list_by_page.dart';
import 'package:flutter_application_1/modules/aditinal/models/add_ticket_model.dart';
import 'package:flutter_application_1/modules/aditinal/models/aditnal_list_model.dart';
import 'package:flutter_application_1/core/common/error_model.dart';

part 'addinal_vist_state.dart';

class AddinalVistCubit extends Cubit<AddinalVistState> {
  AddinalVistCubit() : super(AddinalVistInitial());

  final _apGetAdinalList = GetAdinalListApi();
  final _apiAddTickt = AddTicketApi();

  int page = 1;
  int? totalPage;
  int? totalFilterdPage;
  int filterdPage = 1;
  String? searchKey;
  bool isLoading = false;

  final List<AVQuotationVisit> _addinalList = [];
  final List<AVQuotationVisit> filterList = [];

  List<AVQuotationVisit> get list {
    return searchKey == null ? _addinalList : filterList;
  }

  // List<AVQuotationVisit?> filterdList(String? filter) {
  //   if (filter == null) {
  //     return _addinalList;
  //   }
  //   final List<AVQuotationVisit?> filterdList = [];

  //   addinalList.forEach((e) {
  //     if (e.referenceNo == filter) {
  //       filterdList.add(e);
  //     }
  //   });

  //   return filterdList;
  // }

  Future<void> fetchAddinalList({String? ref, bool? reset}) async {
    isLoading = true;
    emit(AddinalVistLoading());
    if (ref != null || ref != searchKey && ref != null) {
      if (ref != searchKey) {
        filterdPage = 1;
        page = 1;
        totalPage = null;
        totalFilterdPage = null;
        filterList.clear();
      }
      searchKey = ref;
    }

    try {
      if (ref == null) {
        if (totalPage != null) {
          if (totalPage! < page) {
            emit(AddinalVistInitial());
            return;
          }
        }
        final res = await _apGetAdinalList.getAdinalList(page: page);

        if (res is AVQuotationList) {
          _addinalList.addAll(res.data);
          page += 1;

          isLoading = false;
          totalPage = res.totalPages;

          emit(AddinalVistScuccess());
        } else if (res is ErrorModel) {
          isLoading = false;

          emit(AddinalVistError(res.errorMessage));
        }
      } else {
        if (totalFilterdPage != null) {
          if (totalFilterdPage! < filterdPage) {
            emit(AddinalVistScuccess());
            return;
          }
        }
        final res =
            await _apGetAdinalList.getAdinalList(page: filterdPage, ref: ref);

        if (res is AVQuotationList) {
          filterList.addAll(res.data);
          filterdPage += 1;

          isLoading = false;
          totalFilterdPage = res.totalPages;
          emit(AddinalVistScuccess());
        } else if (res is ErrorModel) {
          isLoading = false;

          emit(AddinalVistError(res.errorMessage));
        }
      }
    } catch (e) {
      isLoading = false;
      emit(AddinalVistError('something wrong happend please try again later'));
    }
  }

  Future<void> addTicket(
      {required String refNom, required BuildContext context}) async {
    try {
      emit(AddinalVisitAddTicktLoading());
      final res =
          await _apiAddTickt.addTicket(refNom: refNom, context: context);

      if (res is AddTicketSuccessModel) {
        emit(AddinalVisitAddTicktDone(link: res.message));
        page = 1;
        totalPage = null;
        totalFilterdPage = null;
        filterdPage = 1;
        filterList.clear();
        _addinalList.clear();
        searchKey = null;
        fetchAddinalList();
      } else if (res is ErrorModel) {
        emit(AddinalVistError(res.errorMessage));
      } else {
        emit(AddinalVistError('something worng try again '));
      }
    } catch (e) {
      emit(AddinalVistError('something worng try again '));
    }
  }
}
