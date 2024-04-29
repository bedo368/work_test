import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/core/common/error_model.dart';
import 'package:flutter_application_1/modules/reports/api/local/stages/stage_hive_repo.dart';
import 'package:flutter_application_1/modules/reports/models/stage_models.dart';

part 'stages_state.dart';

class StagesCubit extends Cubit<StagesState> {
  final _stageHiveRepo = StageHiveRepo();
  StagesCubit() : super(StagesInitial());

  List<StageModel> stages = [];

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
      emit(StagesErrorState(message: 'local data error '));
    }
  }
}
