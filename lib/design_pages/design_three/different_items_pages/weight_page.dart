import 'package:flutter/material.dart';
import 'package:prothesvendordashboardprofileshowbyqrcode/design_pages/design_three/common_design/converter_card_design/converter_card_design.dart';

class WeightPage extends StatelessWidget {
  const WeightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weight Converter")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            converterCardDesign("KG to LBS", "Enter kg", (val) {
              double kg = double.tryParse(val) ?? 0;
              return "${(kg * 2.20462).toStringAsFixed(2)} lbs";
            }),
            const SizedBox(height: 16),
            converterCardDesign("LBS to KG", "Enter lbs", (val) {
              double lbs = double.tryParse(val) ?? 0;
              return "${(lbs / 2.20462).toStringAsFixed(2)} kg";
            }),
          ],
        ),
      ),
    );
  }
}