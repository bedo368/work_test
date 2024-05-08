part of 'stages_cubit.dart';

sealed class StagesState extends Equatable {
  const StagesState();

  @override
  List<Object> get props => [];
}

final class StagesInitial extends StagesState {}

final class StagesLoadingState extends StagesState {}

final class StagesErrorState extends StagesState {
  final String message;

  const StagesErrorState({required this.message});
}

final class StagesGetSucessState extends StagesState {}

final class StagesGetProductStageIdSucessState extends StagesState {
  final String productStageId;

  const StagesGetProductStageIdSucessState({required this.productStageId});
}

final class StagesGetProductStageIdLoadingState extends StagesState {}
