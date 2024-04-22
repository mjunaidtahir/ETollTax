import 'package:equatable/equatable.dart';

abstract class TollCubitState extends Equatable {
  const TollCubitState();

  @override
  List<Object> get props => [];
}

class TollInitialState extends TollCubitState {}

class LoadingState extends TollCubitState {}

class TollEntryState extends TollCubitState {}

class TollExitState extends TollCubitState {}

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

// class TotalCostState extends TollCubitState {
//   final double totalCost;

//   const TotalCostState(this.totalCost);
// }

// class NumberPlateState extends TollCubitState {
//   final int numberPlate;

//   const NumberPlateState(this.numberPlate);
// }

class FailedState extends TollCubitState {
  final String errorMessage;

  const FailedState(this.errorMessage);
}
