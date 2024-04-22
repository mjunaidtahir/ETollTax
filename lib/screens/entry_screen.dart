import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolls/bloc/toll_cubit.dart';
import 'package:tolls/bloc/toll_states.dart';
import 'package:tolls/screens/exit_screen.dart';
import 'package:tolls/utils/app_constants.dart';
import 'package:tolls/utils/app_navigaors.dart';
import 'package:tolls/utils/helper_functions.dart';
import 'package:tolls/widgets/app_text_field.dart';
import 'package:tolls/widgets/date_time_widget.dart';
import 'package:tolls/widgets/interchange_widget.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TollCubit, TollCubitState>(
      listener: (context, state) {
        final cubit = context.read<TollCubit>();
        if (state is FailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        } else if (state is TollEntryState) {
          _openTollExitScreen(context, cubit);
        }
      },
      builder: (context, state) {
        final cubit = context.read<TollCubit>();
        return Scaffold(
          body: Center(
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/cloud.png",
                        height: 130,
                      ),
                      const Text(
                        "Welcome Smash Tolls",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: cubit.entryFormKey,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SelectedInterChangeWidget(
                                    interchanges: AppConstants.interchanges,
                                    onInterchangeSelected:
                                        (selectedInterchange) =>
                                            cubit.onSelectedEntryInterchange(
                                                selectedInterchange),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                AppTextField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a number plate';
                                      }
                                      if (!validateNumberPlate(value)) {
                                        return 'Invalid number plate format (LLL-NNN)';
                                      }
                                      return null; // Return null if validation succeeds
                                    },
                                    controller:
                                        cubit.entryNumberPlateController,
                                    hintText: "Number Plat LLL-NNN"),
                                const SizedBox(height: 15),
                                DateTimePicker(
                                  onDateTimeSelected: (value) =>
                                      cubit.onSelectEntryDateTime(value),
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: ElevatedButton(
                                    onPressed: () => cubit.saveEntry(),
                                    child: const Text("Submit"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _openTollExitScreen(BuildContext context, TollCubit cubit) {
    AppNavigator.pushReplacement(context, ExitScreen(tollCubit: cubit));
  }
}
