import 'package:flutter/material.dart';
import 'package:tolls/utils/app_navigaors.dart';

class TotalCostWidget extends StatelessWidget {
  const TotalCostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Text(
                    "Breakdown of cost",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => AppNavigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    "Base Rate:",
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    "\$100",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    "Distance Cost:",
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    "\$100",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    "Subtotal",
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    "\$100",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    "Discount/other",
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    "\$100",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    "TOTAL TO BE CHARGED",
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    "\$100",
                    style: TextStyle(fontSize: 18),
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
  }
}
