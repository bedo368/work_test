import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/core/common/error_model.dart';
import 'package:flutter_application_1/modules/reports/api/local/questions/fuctoins/get_question_data_by_question_id.dart';
import 'package:flutter_application_1/modules/reports/api/local/questions/question_local_repo.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_data_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  QuestionCubit() : super(QuestionInitial());

  List<QuestionModel> questions = [];
  List<QuestionOptionsModel> questionOption = [];
  List<QuestionsOptionDModel> questionOptionData = [];

  final _questionLocalRepo = QuestionLocalRepo();

  List<QuestionsOptionDModel> getQuestionOptionDataByQuestionOptionId(
      String qoid) {
    return questionOptionData.where((element) => element.oID == qoid).toList();
  }

  Future<void> fetchQuestionAndQutionDataBySectionId(
      {required String sectionId}) async {
    emit(QuestionLoadingState());
    try {
      questionOptionData.clear();
      questionOption.clear();
      final data =
          await _questionLocalRepo.getQuestionBySectionId(sectionId: sectionId);
      if (data is List<QuestionModel>) {
        questions = data;

        for (var q in questions) {
          final data = await getQuestionInfoByQuestionIdFunc(questionId: q.qID);
          questionOption.addAll(data['option']);
          questionOptionData.addAll(data['optionData']);
        }

        emit(QuestionGetQuestionByIdSuccessState());
      } else if (data is ErrorModel) {
        emit(QuestionErrorState(message: data.errorMessage));
      } else {
        emit(const QuestionErrorState(message: 'local error happend '));
      }
    } catch (e) {
      emit(const QuestionErrorState(message: 'local error happend '));
    }
  }

  // Future<dynamic> fetchQuestionOptionByQId({required String qId}) async {
  //   try {
  //     final data = await _questionLocalRepo.getQuestionOptoinByQuestionId(
  //         questionId: qId);

  //     if (data is List<QuestionOptionsModel>) {
  //       questionOption = data;
  //       emit(QuestionGetQuestionOptionByQidSuccessState());
  //     } else if (data is ErrorModel) {
  //       emit(QuestionErrorState(message: data.errorMessage));
  //     } else {
  //       emit(QuestionErrorState(message: 'local Error'));
  //     }
  //   } catch (e) {
  //     emit(QuestionErrorState(message: 'local Error'));
  //   }
  // }

  // Future<dynamic> fetchQuestionOptionDataByQOptionId(
  //     {required String qOId}) async {
  //   try {
  //     final data = await _questionLocalRepo
  //         .getQuestionOptionDataByQustionOptionId(qOId: qOId);

  //     if (data is List<QuestionsOptionDModel>) {
  //       questionOptionData = data;
  //       emit(QuestionGetQuestionOptionDataByQOptionIdSuccessState());
  //     } else if (data is ErrorModel) {
  //       emit(QuestionErrorState(message: data.errorMessage));
  //     } else {
  //       emit(QuestionErrorState(message: 'local Error'));
  //     }
  //   } catch (e) {
  //     emit(QuestionErrorState(message: 'local Error'));
  //   }
  // }
}
