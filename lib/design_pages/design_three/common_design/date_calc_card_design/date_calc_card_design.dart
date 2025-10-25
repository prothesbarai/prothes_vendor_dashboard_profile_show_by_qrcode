import 'package:flutter/material.dart';

Widget dateCalcCardDesign() {
  DateTime? date1;
  DateTime? date2;
  String result = "";

  return StatefulBuilder(
    builder: (context, setState) => Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Date Difference Calculator", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => date1 = picked);
              },
              child: Text(date1 == null ? "Select First Date" : date1.toString().split(" ")[0]),
            ),
            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => date2 = picked);
              },
              child: Text(date2 == null ? "Select Second Date" : date2.toString().split(" ")[0]),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (date1 != null && date2 != null) {
                  final diff = date2!.difference(date1!).inDays;
                  setState(() {
                    result = "$diff days";
                  });
                }
              },
              child: const Text("Calculate Difference"),
            ),
            const SizedBox(height: 8),
            Text("Result: $result", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
  );
}

Widget ageCalculatorCardDesign() {
  DateTime? birthDate;
  String result = "";

  return StatefulBuilder(
    builder: (context, setState) => Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Age Calculator", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null) setState(() => birthDate = picked);
              },
              child: Text(birthDate == null ? "Select Birthdate" : birthDate.toString().split(" ")[0]),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (birthDate != null) {
                  final today = DateTime.now();
                  final age = today.year - birthDate!.year - ((today.month < birthDate!.month || (today.month == birthDate!.month && today.day < birthDate!.day)) ? 1 : 0);
                  setState(() {
                    result = "$age years";
                  });
                }
              },
              child: const Text("Calculate Age"),
            ),
            const SizedBox(height: 8),
            Text("Age: $result", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
  );
}