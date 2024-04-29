import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/core/common/error_model.dart';
import 'package:flutter_application_1/modules/reports/api/local/sections/section_local_repo.dart';
import 'package:flutter_application_1/modules/reports/models/section_model.dart';

part 'sections_state.dart';

class SectionsCubit extends Cubit<SectionsState> {
  SectionsCubit() : super(SectionsInitial());
  final _sectionLocalRepo = SectionLocalRepo();

  List<SectionModel> section = [];

  Future<void> fetchSectionByStageId({required String stageId}) async {
    try {
      final data =
          await _sectionLocalRepo.getSectionsByStageId(stageId: stageId);
      if (data is List<SectionModel>) {
        section = data;
        emit(SectionsgetSectionByStageIdSuccess());
      } else if (data is ErrorModel) {
        emit(SectionsErrorState(message: data.errorMessage));
      } else {
        emit(const SectionsErrorState(message: 'local error'));
      }
    } catch (e) {
      emit(const SectionsErrorState(message: 'local error'));
    }
  }
}
