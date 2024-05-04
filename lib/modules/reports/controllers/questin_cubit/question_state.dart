part of 'question_cubit.dart';

sealed class QuestionState extends Equatable {
  const QuestionState();

  @override
  List<Object> get props => [];
}

final class QuestionInitial extends QuestionState {}

final class QuestionErrorState extends QuestionState {
  final String message;

  const QuestionErrorState({required this.message});
}

final class QuestionLoadingState extends QuestionState {}

final class QuestionGetQuestionByIdSuccessState extends QuestionState {}
final class QuestionGetQuestionOptionByQidSuccessState extends QuestionState {}
final class QuestionGetQuestionOptionDataByQOptionIdSuccessState extends QuestionState {}


