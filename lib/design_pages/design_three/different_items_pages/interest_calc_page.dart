import 'package:flutter/material.dart';
import '../common_design/interest_calc_card_design/interest_calc_card_design.dart';

class InterestCalcPage extends StatelessWidget {
  const InterestCalcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Simple Interest Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [interestCalcCardDesign()],
        ),
      ),
    );
  }
}