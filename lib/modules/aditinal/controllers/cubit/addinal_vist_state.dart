part of 'addinal_vist_cubit.dart';

abstract class AddinalVistState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class AddinalVistInitial extends AddinalVistState {}

final class AddinalVistScuccess extends AddinalVistState {}

final class AddinalVistLoading extends AddinalVistState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class AddinalVistError extends AddinalVistState {
  final String message;

  AddinalVistError(this.message);
}

final class AddinalVisitAddTicktLoading extends AddinalVistState {}

final class AddinalVisitAddTicktDone extends AddinalVistState {
  final String link;

  AddinalVisitAddTicktDone({required this.link});
}
