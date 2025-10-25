import 'package:flutter/material.dart';
import 'different_items_pages/bmi_calc_page.dart';
import 'different_items_pages/converters_page.dart';
import 'different_items_pages/date_calc_page.dart';
import 'different_items_pages/interest_calc_page.dart';
import 'different_items_pages/temperature_page.dart';
import 'different_items_pages/weight_page.dart';

class DesignThree extends StatelessWidget {
  final String qrData;
  const DesignThree({super.key,required this.qrData});

  @override
  Widget build(BuildContext context) {
    final List<_Utility> utilities = [
      _Utility("Converters", Icons.swap_horiz, const ConvertersPage()),
      _Utility("Weight", Icons.line_weight, const WeightPage()),
      _Utility("Temperature", Icons.thermostat, const TemperaturePage()),
      _Utility("Date Calc", Icons.calendar_today, const DateCalcPage()),
      _Utility("BMI", Icons.fitness_center, const BMICalcPage()),
      _Utility("Interest", Icons.calculate, const InterestCalcPage()),
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Utility Tools => $qrData")),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: utilities.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 1,),
          itemBuilder: (context, index) {
            final utility = utilities[index];
            return GestureDetector(
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => utility.page),);},
              child: Card(
                elevation: 4,
                color: Colors.blueAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(utility.icon, size: 40, color: Colors.white),
                    const SizedBox(height: 8),
                    Text(utility.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Utility {final String name;final IconData icon;final Widget page;const _Utility(this.name, this.icon, this.page);}