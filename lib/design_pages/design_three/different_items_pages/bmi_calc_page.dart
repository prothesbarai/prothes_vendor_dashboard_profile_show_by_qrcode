import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BMICalcPage extends StatefulWidget {
  const BMICalcPage({super.key});

  @override
  State<BMICalcPage> createState() => _BMICalcPageState();
}

class _BMICalcPageState extends State<BMICalcPage> {

  /// >>> Weight variables
  double weightValue = 60.0;
  String weightUnit = 'Kilograms(kg)';
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
    calculateBMI();
  }


  /// >>> Show Weight Unit Bottom Sheet ========================================
  void _showWeightUnitBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Select Weight Unit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 16),
                  ...['Kilograms(kg)', 'Pounds'].map((unit){
                    return ListTile(
                      selected: true,
                      title: Text(unit),
                      selectedColor: weightUnit == unit ? Colors.blue : null,
                      trailing: weightUnit == unit ? const Icon(Icons.check, color: Colors.blue) : null,
                      onTap: () {
                        setState(() {weightUnit = unit; isCalculated = false;});
                        Navigator.pop(context);
                      },
                    );
                  }),
                ],
              ),
            ),
          );
        },
    );
  }
  /// <<< Show Weight Unit Bottom Sheet ========================================


  /// >>> Show Height Unit Bottom Sheet ========================================
  void _showHeightUnitBottomSheet(){
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Select Height Unit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                const SizedBox(height: 16),
                ...['Centimeters', 'Meters', 'Feet', 'Inches'].map((unit){
                  return ListTile(
                    selected: true,
                    selectedColor: heightUnit == unit ? Colors.blue : null,
                    title: Text(unit),
                    trailing: heightUnit == unit ? const Icon(Icons.check, color: Colors.blue) : null,
                    onTap: () {
                      setState(() {heightUnit = unit;isCalculated = false;});
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
  /// <<< Show Height Unit Bottom Sheet ========================================


  /// >>> BMI Result Category Color ============================================
  Color _getCategoryColor() {
    if (bmiCategory == 'Underweight') return Colors.blue;
    if (bmiCategory == 'Normal') return Colors.green;
    if (bmiCategory == 'Overweight') return Colors.orange;
    return Colors.red;
  }
  /// <<< BMI Result Category Color ============================================


  /// >>> BMI Calculation ======================================================
  void calculateBMI() {
    double weightInKg = weightValue;
    double heightInM = heightValue / 100; // Convert cm to meters

    // Convert weight to kg for Pounds
    if(weightUnit == 'Pounds'){
      weightInKg = weightValue * 0.453592;
    }

    // Convert height to other
    if (heightUnit == 'Meters') {
      heightInM = heightValue;
    } else if (heightUnit == 'Feet') {
      heightInM = heightValue * 0.3048;
    } else if (heightUnit == 'Inches') {
      heightInM = heightValue * 0.0254;
    }

    if (heightInM > 0) {
      setState(() {
        bmiResult = weightInKg / (heightInM * heightInM);
        isCalculated = true;

        if (bmiResult < 18.5) {
          bmiCategory = 'Underweight';
        } else if (bmiResult < 24.9) {
          bmiCategory = 'Normal';
        } else if (bmiResult < 30) {
          bmiCategory = 'Overweight';
        } else {
          bmiCategory = 'Obese';
        }
      });
    }

  }
  /// <<< BMI Calculation ======================================================

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
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
                    onTap: _showWeightUnitBottomSheet,
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
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}(\.\d{0,2})?$'),),],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(border: InputBorder.none, hintText: 'Enter weight', labelText: 'Weight',),
                        onChanged: (value){
                          setState(() {weightValue = double.tryParse(value) ?? 0.0;isCalculated = false;});
                        },
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
                    onTap: _showHeightUnitBottomSheet,
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
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}(\.\d{0,2})?$'),),],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(border: InputBorder.none, hintText: 'Enter height', labelText: 'Height',),
                        onChanged: (value){
                          setState(() {heightValue = double.tryParse(value) ?? 0.0;isCalculated = false;});
                        },
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
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),),
                child: const Text('Calculate BMI', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ),
            ),
            const SizedBox(height: 30),
            /// <<< Calculate Button End Here ==================================


            /// >>> BMI Result Card - Only show if calculated ==================
            if (isCalculated) ...[
              _buildCard(bmiValue: bmiResult, bmiCategory: bmiCategory, weight:  weightValue, height: heightValue, weightUnit: weightUnit, heightUnit: heightUnit),
              const SizedBox(height: 20),
            ],
            /// <<< BMI Result Card - Only show if calculated ==================


            /// >>> BMI Scale Information ======================================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[300]!),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 12),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Underweight'), Text('Normal'), Text('Overweight'),],),
                  const SizedBox(height: 8),
                  Container(
                    height: 20,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: const LinearGradient(colors: [Colors.blue, Colors.green, Colors.orange, Colors.red,], stops: [0.0, 0.3, 0.6, 1.0],),),
                  ),
                  const SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('16.0'), Text('18.5'), Text('25.0'), Text('40.0'),],),
                ],
              ),
            ),
            const SizedBox(height: 100),
            /// <<< BMI Scale Information ======================================
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(  bmiValue.toStringAsFixed(1).length > 6 ? '${bmiValue.toStringAsFixed(1).substring(0, 4)}...' : bmiValue.toStringAsFixed(1), style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Colors.blue,),),
              SizedBox(width: 15,),
              Column(
                children: [
                  Text('BMI', style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.grey,),),
                  Text(bmiCategory, style: TextStyle(fontSize: 12, color: _getCategoryColor(),),),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(bmiCategory, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: _getCategoryColor(),),),
          const SizedBox(height: 8),
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