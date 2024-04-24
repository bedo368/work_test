import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/core/common/error_model.dart';
import 'package:flutter_application_1/modules/add_ticket/api/repo/add_tickt_repo.dart';
import 'package:flutter_application_1/modules/add_ticket/models/degree_model.dart';
import 'package:flutter_application_1/modules/add_ticket/models/transfer_to_model.dart';

part 'add_tickt_state.dart';

class AddTicktCubit extends Cubit<AddTicktState> {
  AddTicktCubit() : super(AddTicktInitial());
  final _repo = AddTicktRepo();

  Map<String, TransferToModel> _transferToList = {};
  Map<String, DegreeModel> _degreeList = {};

  List<TransferToModel> get transferModelList =>
      _transferToList.values.toList();
  List<DegreeModel> get degreeList => _degreeList.values.toList();

  Future<void> getRefNomList() async {
    emit(AddTicktLoadingState());
    if (_transferToList.isNotEmpty) {
      emit(AddTicktGetRefNomListSuccess());
      print(state);

      return;
    }

    try {
      final res = await _repo.getRefNomList();
      if (res is TransferToListModel) {
        _transferToList = res.list;
        emit(AddTicktGetRefNomListSuccess());
      } else if (res is ErrorModel) {
        emit(AddTicktErrorState(message: res.errorMessage));
      } else {
        emit(const AddTicktErrorState(message: 'something wrong happend '));
      }
    } catch (e) {
      emit(const AddTicktErrorState(message: 'something wrong happend '));
    }
  }

  Future<void> getDegreeList() async {
    emit(AddTicktLoadingState());

    if (_degreeList.isNotEmpty) {
      emit(AddTicktGetDegreeListSuccess());
      print(state);

      return;
    }

    try {
      final res = await _repo.getDegreeList();
      if (res is DegreeListModel) {
        _degreeList = res.degrees;
        emit(AddTicktGetDegreeListSuccess());
      } else if (res is ErrorModel) {
        emit(AddTicktErrorState(message: res.errorMessage));
      } else {
        emit(const AddTicktErrorState(message: 'something wrong happend '));
      }
    } catch (e) {
      emit(const AddTicktErrorState(message: 'something wrong happend '));
    }
  }

  Future<void> addTicketWithRefNom(
      {required String refNom,
      required String transferTotype,
      required String disc}) async {
    try {
      final res = await _repo.addTeicketWithTransferId(
          disc: disc, refNom: refNom, transferIdType: transferTotype);
      print(res);
    } catch (e) {
      emit(const AddTicktErrorState(message: 'wrong'));
    }
  }
}
