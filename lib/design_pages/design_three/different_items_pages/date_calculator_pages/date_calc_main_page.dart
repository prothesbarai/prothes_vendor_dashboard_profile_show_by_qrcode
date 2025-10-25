import 'package:flutter/material.dart';
import 'age_calculator_page.dart';
import 'date_calc_page.dart';

class DateCalcMainPage extends StatelessWidget {
  const DateCalcMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tools = [
      {"title": "Date Calculator", "icon": Icons.calendar_today},
      {"title": "Age Calculator", "icon": Icons.cake},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Date Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemCount: tools.length,
          itemBuilder: (context, index) {
            final item = tools[index];
            return GestureDetector(
              onTap: () {
                if (item["title"] == "Date Calculator") {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const DateCalcPage()),);
                }if (item["title"] == "Age Calculator") {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AgeCalculatorPage()),);
                }
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item["icon"], size: 40, color: Colors.deepOrange),
                    const SizedBox(height: 10),
                    Text(
                      item["title"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500,),
                    ),
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
