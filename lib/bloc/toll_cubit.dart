import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolls/bloc/toll_states.dart';
import 'package:tolls/models/interChange.dart';

class TollCubit extends Cubit<TollCubitState> {
  TollCubit() : super(TollInitialState());
  final entryFormKey = GlobalKey<FormState>();
  final exitFormKey = GlobalKey<FormState>();

  final TextEditingController entryNumberPlatController =
      TextEditingController();
  final TextEditingController exitNumberPlatController =
      TextEditingController();

  int baseRate = 20;
  Interchange? selectedEntryInterChange;
  Interchange? selectedExitInterChange;
  DateTime? entryDateTime;
  DateTime? exitDateTime;

  void onSelectedEntryInterChange(Interchange interchange) {
    selectedEntryInterChange = interchange;
    print(selectedEntryInterChange?.name);
  }

  void onSelectionExitInterChange(Interchange interchange) {
    selectedExitInterChange = interchange;
    print(selectedExitInterChange?.name);
  }

  void onSelectEntryDateTime(DateTime dateTime) {
    entryDateTime = dateTime;
    print(entryDateTime);
  }

  void onSelectExitDateTime(DateTime dateTime) {
    exitDateTime = dateTime;
    print(exitDateTime);
  }

  void saveEntry() {
    emit(LoadingState());

    if (selectedEntryInterChange == null) {
      emit(const FailedState("Please select entry interchange"));
      return;
    } else if (entryDateTime == null) {
      emit(const FailedState("Please select entry date and time"));
      return;
    } else if (entryFormKey.currentState!.validate()) {
      print("validate");
    }
  }
}
