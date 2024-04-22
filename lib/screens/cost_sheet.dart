import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolls/bloc/toll_cubit.dart';
import 'package:tolls/bloc/toll_states.dart';

class TotalCostWidget extends StatelessWidget {
  const TotalCostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TollCubit, TollCubitState>(
      builder: (context, state) {
        final cubit = context.read<TollCubit>();
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Row(
                    children: [
                      Text(
                        "Breakdown of cost",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        "Base Rate:",
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      Text(
                        "${double.parse(cubit.baseRate.toString())}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Distance Cost:",
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      Text(
                        "${double.parse(cubit.distanceCost.toString())}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Subtotal",
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      Text(
                        "${double.parse(cubit.distanceCost.toString())}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Discount/other",
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      Text(
                        "${double.parse(cubit.distanceCost.toString())}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "TOTAL TO BE CHARGED",
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      Text(
                        "${double.parse(cubit.distanceCost.toString())}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(onPressed: () {}, child: const Text("Done"))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
