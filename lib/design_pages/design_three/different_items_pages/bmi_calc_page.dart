import 'package:flutter/material.dart';
import '../common_design/bmi_card_design/bmi_card_design.dart';

class BMICalcPage extends StatelessWidget {
  const BMICalcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BMI Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [bmiCardDesign()],
        ),
      ),
    );
  }
}