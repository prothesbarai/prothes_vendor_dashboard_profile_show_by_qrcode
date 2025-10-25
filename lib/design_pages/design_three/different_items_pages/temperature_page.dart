import 'package:flutter/material.dart';

import '../common_design/converter_card_design/converter_card_design.dart';


class TemperaturePage extends StatelessWidget {
  const TemperaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Temperature Converter")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            converterCardDesign("Celsius to Fahrenheit", "Enter °C", (val) {
              double c = double.tryParse(val) ?? 0;
              return "${(c * 9 / 5 + 32).toStringAsFixed(2)} °F";
            }),
            const SizedBox(height: 16),
            converterCardDesign("Fahrenheit to Celsius", "Enter °F", (val) {
              double f = double.tryParse(val) ?? 0;
              return "${((f - 32) * 5 / 9).toStringAsFixed(2)} °C";
            }),
          ],
        ),
      ),
    );
  }
}