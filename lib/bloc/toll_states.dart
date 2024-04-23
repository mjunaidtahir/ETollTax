import 'package:equatable/equatable.dart';
import 'package:tolls/models/interChange.dart';

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

class TollFaresCalculatedState extends TollCubitState {
  final double totalCost;

  const TollFaresCalculatedState(this.totalCost);
  @override
  List<Object> get props => [totalCost];
}

class FailedState extends TollCubitState {
  final String errorMessage;

  const FailedState(this.errorMessage);
}

class EntryInterChangeState extends TollCubitState {
  Interchange interChange;

  EntryInterChangeState(this.interChange);
  @override
  List<Object> get props => [interChange];
}

class ExitInterChangeState extends TollCubitState {
  Interchange interChange;

  ExitInterChangeState(this.interChange);
  @override
  List<Object> get props => [interChange];
}
