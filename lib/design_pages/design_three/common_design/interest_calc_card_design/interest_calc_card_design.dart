import 'package:flutter/material.dart';


Widget interestCalcCardDesign() {
  final TextEditingController principalController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  String result = "";

  return StatefulBuilder(
    builder: (context, setState) => Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Simple Interest Calculator", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: principalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Principal", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Rate (%)", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: timeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Time (years)", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                double principal = double.tryParse(principalController.text) ?? 0;
                double rate = double.tryParse(rateController.text) ?? 0;
                double time = double.tryParse(timeController.text) ?? 0;
                if (principal > 0 && rate > 0 && time > 0) {
                  double interest = (principal * rate * time) / 100;
                  setState(() {
                    result = "Interest: ${interest.toStringAsFixed(2)}";
                  });
                }
              },
              child: const Text("Calculate Interest"),
            ),
            const SizedBox(height: 8),
            Text(result, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
  );
}
