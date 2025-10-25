import 'package:flutter/material.dart';

Widget bmiCardDesign() {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String result = "";

  return StatefulBuilder(
    builder: (context, setState) => Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("BMI Calculator", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Height in meters", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Weight in kg", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final double height = double.tryParse(heightController.text) ?? 0;
                final double weight = double.tryParse(weightController.text) ?? 0;
                if (height > 0 && weight > 0) {
                  final bmi = weight / (height * height);
                  setState(() {
                    result = "BMI: ${bmi.toStringAsFixed(2)}";
                  });
                }
              },
              child: const Text("Calculate BMI"),
            ),
            const SizedBox(height: 8),
            Text(result, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
  );
}