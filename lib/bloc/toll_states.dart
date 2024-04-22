import 'package:equatable/equatable.dart';

abstract class TollCubitState extends Equatable {
  const TollCubitState();

  @override
  List<Object> get props => [];
}

class TollInitialState extends TollCubitState {}

class LoadingState extends TollCubitState {}

class TollEntryState extends TollCubitState {
  @override
  List<Object> get props => [];
}

class TollExitState extends TollCubitState {
  @override
  List<Object> get props => [];
}

// class EntryDateTimeState extends TollCubitState {
//   final String entryDate;
//   final String time;

//   const EntryDateTimeState(this.entryDate, this.time);
// }

// class ExitDateTimeState extends TollCubitState {
//   final String exitDate;
//   final String time;

//   const ExitDateTimeState(this.exitDate, this.time);
// }

class TollFaresCalculatedState extends TollCubitState {
  final double totalCost;

  const TollFaresCalculatedState(this.totalCost);
  @override
  List<Object> get props => [totalCost];
}

// class NumberPlateState extends TollCubitState {
//   final int numberPlate;

//   const NumberPlateState(this.numberPlate);
// }

class FailedState extends TollCubitState {
  final String errorMessage;

  const FailedState(this.errorMessage);
}
