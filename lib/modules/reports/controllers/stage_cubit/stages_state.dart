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

  StagesErrorState({required this.message});
}

final class StagesGetSucessState extends StagesState {}
