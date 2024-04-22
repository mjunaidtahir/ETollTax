import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolls/bloc/toll_states.dart';
import 'package:tolls/models/interChange.dart';

class TollCubit extends Cubit<TollCubitState> {
  TollCubit() : super(TollInitialState());
  final entryFormKey = GlobalKey<FormState>();
  final exitFormKey = GlobalKey<FormState>();

  final TextEditingController entryNumberPlateController =
      TextEditingController();
  final TextEditingController exitNumberPlateController =
      TextEditingController();

  double baseRate = 20;
  double distanceRate = 0.2;
  double weekendRateMultiplier = 1.5;
  double evenOddDiscount = 0.1;
  double holidayDiscount = 0.5;
  double distance = 0;
  double distanceCost = 0;
  Interchange? selectedEntryInterchange;
  Interchange? selectedExitInterchange;
  DateTime? entryDateTime;
  DateTime? exitDateTime;

  List<DateTime> nationalHolidays = [
    DateTime(DateTime.now().year, DateTime.march, 23),
    DateTime(DateTime.now().year, DateTime.august, 14),
    DateTime(DateTime.now().year, DateTime.december, 25),
  ];

  void onSelectedEntryInterchange(Interchange interchange) {
    selectedEntryInterchange = interchange;
  }

  void onSelectedExitInterchange(Interchange interchange) {
    emit(LoadingState());
    if (selectedEntryInterchange == interchange) {
      emit(const FailedState(
          "Entry Point and Exit Point Should Not be the same"));
    } else {
      selectedExitInterchange = interchange;
    }
  }

  void onSelectEntryDateTime(DateTime dateTime) {
    entryDateTime = dateTime;
  }

  void onSelectExitDateTime(DateTime dateTime) {
    exitDateTime = dateTime;
  }

  void saveEntry() {
    emit(LoadingState());

    if (selectedEntryInterchange == null) {
      emit(const FailedState("Please select entry interchange"));
      return;
    } else if (entryDateTime == null) {
      emit(const FailedState("Please select entry date and time"));
      return;
    } else if (entryDateTime!.isBefore(DateTime.now())) {
      emit(const FailedState("Entry date and time cannot be in the past"));
      return;
    } else if (entryFormKey.currentState!.validate()) {
      emit(TollEntryState());
      return;
    } else {
      emit(const FailedState("Please fill all the fields"));
      return;
    }
  }

  void calculateFares() {
    emit(LoadingState());

    if (selectedEntryInterchange == null && selectedExitInterchange == null) {
      emit(const FailedState("Please select exit interchange"));
      return;
    } else if (exitDateTime == null) {
      emit(const FailedState("Please select exit date and time"));
      return;
    } else if (entryNumberPlateController.text !=
        exitNumberPlateController.text) {
      emit(const FailedState("Entry and Exit Number Plate Should be the Same"));
      return;
    } else if (exitDateTime!.isBefore(DateTime.now())) {
      emit(const FailedState("Exit date and time cannot be in the past"));
      return;
    } else if (exitFormKey.currentState!.validate()) {
      emit(TollExitState());
      double totalFare = baseRate;

      distance = selectedEntryInterchange!.distance.toDouble() +
          selectedExitInterchange!.distance.toDouble();

      totalFare += distance * distanceRate;

      if (exitDateTime!.weekday == DateTime.saturday ||
          exitDateTime!.weekday == DateTime.sunday) {
        totalFare *= weekendRateMultiplier;
      }
      if (exitDateTime!.weekday == DateTime.monday ||
          exitDateTime!.weekday == DateTime.wednesday) {
        int lastDigit = int.tryParse(exitNumberPlateController.text
                .substring(exitNumberPlateController.text.length - 1)) ??
            0;
        if (lastDigit % 2 == 0) {
          totalFare *= (1 - evenOddDiscount);
        }
      } else if (exitDateTime!.weekday == DateTime.tuesday ||
          exitDateTime!.weekday == DateTime.thursday) {
        int lastDigit = int.tryParse(exitNumberPlateController.text
                .substring(exitNumberPlateController.text.length - 1)) ??
            0;
        if (lastDigit % 2 != 0) {
          totalFare *= (1 - evenOddDiscount);
        }
      }

      if (nationalHolidays.contains(exitDateTime!)) {
        totalFare *= (1 - holidayDiscount);
      }
      printFareDetails(totalFare);
      emit(TollFaresCalculatedState(totalFare));
      return;
    } else {
      emit(const FailedState("Please fill all the fields"));
      return;
    }
  }

  void printFareDetails(double totalFare) {
    distance = selectedEntryInterchange!.distance.toDouble() +
        selectedExitInterchange!.distance.toDouble();

    print('Total Distance Traveled: $distance KM');
    print('Total Fare: $totalFare rupees');
    double totalCost = baseRate + (distance * distanceRate);
    double totalDiscount = totalCost - totalFare;
    print('Total Discount: $totalDiscount rupees');
  }
}
