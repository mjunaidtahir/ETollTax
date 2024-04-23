import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolls/bloc/toll_states.dart';
import 'package:tolls/models/interChange.dart';
import 'package:tolls/utils/app_constants.dart';

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
  double totalFare = 0;
  double totalCost = 0;
  double totalDiscount = 0;
  DateTime? entryDateTime;
  DateTime? exitDateTime;
  Interchange? selectedEntryInterchange;
  Interchange? selectedExitInterchange;

  List<DateTime> nationalHolidays = [
    DateTime(DateTime.now().year, DateTime.march, 23),
    DateTime(DateTime.now().year, DateTime.august, 14),
    DateTime(DateTime.now().year, DateTime.december, 25),
  ];

  void onSelectedEntryInterchange(Interchange interchange) {
    selectedEntryInterchange = interchange;
    emit(EntryInterChangeState(interchange));
  }

  void onSelectedExitInterchange(Interchange interchange) {
    emit(LoadingState());
    if (selectedEntryInterchange == interchange) {
      selectedExitInterchange = null;
      emit(const FailedState(
          "Entry Point and Exit Point Should Not be the same"));
    } else {
      selectedExitInterchange = interchange;
      emit(ExitInterChangeState(interchange));
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
    if (selectedEntryInterchange == null || selectedExitInterchange == null) {
      emit(const FailedState("Please select both entry and exit interchanges"));
      return;
    } else if (selectedEntryInterchange!.distance >
        selectedExitInterchange!.distance) {
      emit(const FailedState("Entry Distance Must be less than Exit point"));
      return;
    } else if (exitDateTime == null) {
      emit(const FailedState("Please select exit date and time"));
      return;
    } else if (entryNumberPlateController.text !=
        exitNumberPlateController.text) {
      emit(const FailedState("Entry and Exit Number Plate Should be the Same"));
      return;
    } else if (exitDateTime!.isBefore(entryDateTime!)) {
      emit(const FailedState("Exit date and time cannot be in the past"));
      return;
    } else if (selectedExitInterchange == AppConstants.interchanges[0]) {
      emit(
          const FailedState("Exit interchange cannot be the Zero Interchange"));
      return;
    } else if (exitFormKey.currentState!.validate()) {
      distance = selectedExitInterchange!.distance.toDouble() -
          selectedEntryInterchange!.distance.toDouble();
      distanceCost = distance * distanceRate;

      if (exitDateTime!.weekday == DateTime.saturday ||
          exitDateTime!.weekday == DateTime.sunday) {
        distanceCost *= weekendRateMultiplier;
      }

      bool isEvenPlate = int.tryParse(exitNumberPlateController.text
                  .substring(exitNumberPlateController.text.length - 1))! %
              2 ==
          0;
      if ((exitDateTime!.weekday == DateTime.monday ||
              exitDateTime!.weekday == DateTime.wednesday) &&
          isEvenPlate) {
        distanceCost *= (1 - evenOddDiscount);
      } else if ((exitDateTime!.weekday == DateTime.tuesday ||
              exitDateTime!.weekday == DateTime.thursday) &&
          !isEvenPlate) {
        distanceCost *= (1 - evenOddDiscount);
      }

      if (nationalHolidays.contains(DateTime(
          exitDateTime!.year, exitDateTime!.month, exitDateTime!.day))) {
        distanceCost *= (1 - holidayDiscount);
      }

      totalFare = baseRate + distanceCost;
      totalCost = baseRate + (distance * distanceRate);
      totalDiscount = totalCost - totalFare;

      printFareDetails(totalFare, totalCost, totalDiscount);

      emit(TollFaresCalculatedState(totalFare));
    } else {
      emit(const FailedState("Please fill all the fields"));
    }
  }

  void printFareDetails(
      double totalFare, double totalCost, double totalDiscount) {
    debugPrint('Total Distance Traveled: $distance KM');
    debugPrint('Total Fare: $totalFare rupees');
    debugPrint('Total Discount: $totalDiscount rupees');
    debugPrint('Overall Total Cost: $totalCost rupees');
  }
}
