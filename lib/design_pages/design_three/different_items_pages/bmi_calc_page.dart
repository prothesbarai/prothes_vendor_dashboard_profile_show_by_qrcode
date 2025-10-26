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
                        controller: weightController,
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
                        controller: heightController,
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


            /// <<< Calculate Button Start Here ================================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),),
                child: const Text('Calculate BMI', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ),
            ),
            const SizedBox(height: 30),
            /// <<< Calculate Button End Here ==================================


            /// >>> BMI Result Card - Only show if calculated ==================
            _buildCard(bmiValue: 20, bmiCategory: bmiCategory, weight: 20, height: 50, weightUnit: weightUnit, heightUnit: heightUnit)
            /// <<< BMI Result Card - Only show if calculated ==================
          ],
        ),
      )
    );
  }


  /// >>> Separate Card Design Start Here ======================================
  Widget _buildCard({required double bmiValue, required String bmiCategory, required double weight, required double height, required String weightUnit, required String heightUnit}){
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.blue[200]!),),
      child: Column(
        children: [
          Text('${bmiValue.toStringAsFixed(1)} BMI', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue,),),
          const SizedBox(height: 8),
          Text(bmiCategory, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, /*color: _getCategoryColor(),*/),),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text('Weight', style: TextStyle(fontSize: 14, color: Colors.grey),),
                  Text(weight.toStringAsFixed(0), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
                  Text(weightUnit, style: const TextStyle(fontSize: 12, color: Colors.grey),),
                ],
              ),
              Column(
                children: [
                  const Text('Height', style: TextStyle(fontSize: 14, color: Colors.grey),),
                  Text(height.toStringAsFixed(0), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
                  Text(heightUnit, style: const TextStyle(fontSize: 12, color: Colors.grey),),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  /// <<< Separate Card Design End Here ========================================
}