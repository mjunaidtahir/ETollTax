import 'package:flutter/material.dart';
import 'package:tolls/screens/cost_sheet.dart';
import 'package:tolls/utils/app_constants.dart';
import 'package:tolls/widgets/app_bottom_sheet.dart';
import 'package:tolls/widgets/app_text_field.dart';
import 'package:tolls/widgets/date_time_widget.dart';
import 'package:tolls/widgets/interchange_widget.dart';

class ExitScreen extends StatelessWidget {
  const ExitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                  Card(
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
                              onInterchangeSelected: (selectedInterchange) {
                                print(
                                    'Selected Interchange: ${selectedInterchange.name}, ${selectedInterchange.distance} KM');
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          const AppTextField(hintText: "Number Plat LLL-NNN"),
                          const SizedBox(height: 15),
                          DateTimePicker(
                            onDateTimeSelected: (_) {},
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: ElevatedButton(
                              onPressed: () => _showTotalCost(context),
                              child: const Text("Calculate"),
                            ),
                          )
                        ],
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
