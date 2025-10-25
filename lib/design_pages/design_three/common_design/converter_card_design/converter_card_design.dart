import 'package:flutter/material.dart';

Widget converterCardDesign(String title, String hint, String Function(String) calculate) {
  final TextEditingController controller = TextEditingController();
  String result = "";

  return StatefulBuilder(
    builder: (context, setState) => Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: hint, border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  result = calculate(controller.text);
                });
              },
              child: const Text("Calculate"),
            ),
            const SizedBox(height: 8),
            Text("Result: $result", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
  );
}