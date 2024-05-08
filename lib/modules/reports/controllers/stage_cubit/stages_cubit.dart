import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/core/common/error_model.dart';
import 'package:flutter_application_1/modules/reports/api/local/stages/stage_hive_repo.dart';
import 'package:flutter_application_1/modules/reports/api/server/get_product_stage_id.dart';
import 'package:flutter_application_1/modules/reports/models/project_stage_response_model.dart';
import 'package:flutter_application_1/modules/reports/models/stage_models.dart';

part 'stages_state.dart';

class StagesCubit extends Cubit<StagesState> {
  final _stageHiveRepo = StageHiveRepo();
  StagesCubit() : super(StagesInitial());

  List<StageModel> stages = [];

  // Asynchronously retrieves stages from local storage and emits corresponding states based on the result.
  Future<void> getStagesFromLocalStorage() async {
    try {
      final stagess = await _stageHiveRepo.fetchAllStagesFromHive();

      if (stagess is List<StageModel>) {
        stages = stagess;
        emit(StagesGetSucessState());
      } else if (stagess is ErrorModel) {
        emit(StagesErrorState(message: stagess.errorMessage));
      }
    } catch (e) {
      emit(const StagesErrorState(message: 'local data error '));
    }
  }

  Future<void> getProductStageId(
      {required String stageId,
      required String projectNo,
      required String location}) async {
    try {
      emit(StagesGetProductStageIdLoadingState());
      final res = await getProjectStageId(
          stageId: stageId, projectNom: projectNo, location: location);

      if (res is StageResponse) {
        emit(StagesGetProductStageIdSucessState(productStageId: res.pStageId));
      } else if (res is ErrorModel) {
        emit(StagesErrorState(message: res.errorMessage));
      } else {
        emit(const StagesErrorState(
            message: 'some thing worng with getting project stage id '));
      }
    } catch (e) {
      emit(const StagesErrorState(
          message: 'some thing worng with getting project stage id '));
    }
  }
}
