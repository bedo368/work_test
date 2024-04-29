part of 'sections_cubit.dart';

sealed class SectionsState extends Equatable {
  const SectionsState();

  @override
  List<Object> get props => [];
}

final class SectionsInitial extends SectionsState {}

final class SectionsErrorState extends SectionsState {
  final String message;

  SectionsErrorState({required this.message});
}

final class SectionsLoadingState extends SectionsState {}

final class SectionsgetSectionByStageIdSuccess extends SectionsState {}
