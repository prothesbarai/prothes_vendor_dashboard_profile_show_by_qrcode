import 'package:flutter/material.dart';
import '../common_design/converter_card_design/converter_card_design.dart';

class ConvertersPage extends StatelessWidget {
  const ConvertersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Converters")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            converterCardDesign("Meter to Kilometer", "Enter meters", (val) {
              double meter = double.tryParse(val) ?? 0;
              return "${meter / 1000} km";
            }),
            const SizedBox(height: 16),
            converterCardDesign("Inch to Feet", "Enter inches", (val) {
              double inch = double.tryParse(val) ?? 0;
              return "${inch / 12} ft";
            }),
          ],
        ),
      ),
    );
  }
}