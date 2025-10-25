import 'package:flutter/material.dart';
import '../common_design/date_calc_card_design/date_calc_card_design.dart';

class DateCalcPage extends StatelessWidget {
  const DateCalcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Date Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            dateCalcCardDesign(),
            const SizedBox(height: 16),
            ageCalculatorCardDesign(),
          ],
        ),
      ),
    );
  }
}