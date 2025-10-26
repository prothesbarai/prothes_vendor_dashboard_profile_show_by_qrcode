import 'package:flutter/material.dart';

class BMICalcPage extends StatefulWidget {
  const BMICalcPage({super.key});

  @override
  State<BMICalcPage> createState() => _BMICalcPageState();
}

class _BMICalcPageState extends State<BMICalcPage> {

  /// >>> Weight variables
  double weightValue = 60.0;
  String weightUnit = 'Kilograms';
  TextEditingController weightController = TextEditingController();

  /// >>> Height variables
  double heightValue = 170.0;
  String heightUnit = 'Centimeters';
  TextEditingController heightController = TextEditingController();

  /// >>> BMI result
  double bmiResult = 0.0;
  String bmiCategory = '';
  bool isCalculated = false;


  @override
  void initState() {
    super.initState();
    weightController.text = weightValue.toStringAsFixed(0);
    heightController.text = heightValue.toStringAsFixed(0);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BMI Calculator")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// >>> Weight Input Field Start Here ==============================
            Container(
              decoration: BoxDecoration(color: Colors.grey[100],borderRadius: BorderRadius.circular(12),border: Border.all(color: Colors.grey[300]!)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(8),border: Border.all(color: Colors.grey[400]!),),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(weightUnit, style: const TextStyle(fontSize: 16),),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_drop_down, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(border: InputBorder.none, hintText: 'Enter weight', labelText: 'Weight',),
                        onChanged: (value){},
                      )
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            /// <<< Weight Field End Here ======================================

            /// >>> Height Input Field Start Here ==============================
            Container(
              decoration: BoxDecoration(color: Colors.grey[100],borderRadius: BorderRadius.circular(12),border: Border.all(color: Colors.grey[300]!)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(8),border: Border.all(color: Colors.grey[400]!),),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(heightUnit, style: const TextStyle(fontSize: 16),),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_drop_down, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(border: InputBorder.none, hintText: 'Enter height', labelText: 'Height',),
                        onChanged: (value){},
                      )
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            /// <<< Height Input Field End Here ================================
          ],
        ),
      )
    );
  }
}