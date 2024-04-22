import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolls/bloc/toll_cubit.dart';
import 'package:tolls/bloc/toll_states.dart';
import 'package:tolls/screens/cost_sheet.dart';
import 'package:tolls/utils/app_constants.dart';
import 'package:tolls/utils/helper_functions.dart';
import 'package:tolls/widgets/app_bottom_sheet.dart';
import 'package:tolls/widgets/app_text_field.dart';
import 'package:tolls/widgets/date_time_widget.dart';
import 'package:tolls/widgets/interchange_widget.dart';

class ExitScreen extends StatelessWidget {
  final TollCubit tollCubit;
  const ExitScreen({super.key, required this.tollCubit});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TollCubit, TollCubitState>(
      listener: (context, state) {
        if (state is FailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        } else if (state is TollFaresCalculatedState) {
          _showTotalCost(context);
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
                        "GoodBye! Have a Smash day!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: cubit.exitFormKey,
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
                                            cubit.onSelectedExitInterchange(
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
                                    controller: cubit.exitNumberPlateController,
                                    hintText: "Number Plat LLL-NNN"),
                                const SizedBox(height: 15),
                                DateTimePicker(
                                  onDateTimeSelected: (value) =>
                                      cubit.onSelectExitDateTime(value),
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: ElevatedButton(
                                    onPressed: () => cubit.calculateFares(),
                                    child: const Text("Calculate"),
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

  void _showTotalCost(BuildContext context) {
    AppBottomSheet.showScrollableBottomSheet(
      context: context,
      minChildSize: 0.4,
      builder: (context, scrollController) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: TotalCostWidget(),
        );
      },
    );
  }
}
