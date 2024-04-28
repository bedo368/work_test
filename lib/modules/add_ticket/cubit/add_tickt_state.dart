part of 'add_tickt_cubit.dart';

sealed class AddTicktState extends Equatable {
  const AddTicktState();

  @override
  List<Object> get props => [];
}

final class AddTicktInitial extends AddTicktState {}

final class AddTicktGetRefNomListStart extends AddTicktState {}

final class AddTicktLoadingState extends AddTicktState {}

final class AddTicktGetRefNomListSuccess extends AddTicktState {}

final class AddTicktGetDegreeListStart extends AddTicktState {}

final class AddTicktGetDegreeListSuccess extends AddTicktState {}

final class AddTicktErrorState extends AddTicktState {
  const AddTicktErrorState({required this.message});
  final String message;
}

final class AddTicktWithTransferIdSuccess extends AddTicktState {}


final class AddTicktWithDegreeIdSuccess extends AddTicktState {}

final class AddTicktWithDegreeIdOrTransferIdLoading extends AddTicktState {}
