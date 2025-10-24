import 'package:flutter/material.dart';

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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final utility = utilities[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => utility.page),
                );
              },
              child: Card(
                elevation: 4,
                color: Colors.blueAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(utility.icon, size: 40, color: Colors.white),
                    const SizedBox(height: 8),
                    Text(
                      utility.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
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

class _Utility {final String name;final IconData icon;final Widget page;const _Utility(this.name, this.icon, this.page);}

// ==========================================
// ================= Pages ==================
// ==========================================

// ---------------- Converters ----------------
class ConvertersPage extends StatelessWidget {
  const ConvertersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Converters")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _converterCard("Meter to Kilometer", "Enter meters", (val) {
              double meter = double.tryParse(val) ?? 0;
              return "${meter / 1000} km";
            }),
            const SizedBox(height: 16),
            _converterCard("Inch to Feet", "Enter inches", (val) {
              double inch = double.tryParse(val) ?? 0;
              return "${inch / 12} ft";
            }),
          ],
        ),
      ),
    );
  }
}

// ---------------- Weight ----------------
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
            _converterCard("KG to LBS", "Enter kg", (val) {
              double kg = double.tryParse(val) ?? 0;
              return "${(kg * 2.20462).toStringAsFixed(2)} lbs";
            }),
            const SizedBox(height: 16),
            _converterCard("LBS to KG", "Enter lbs", (val) {
              double lbs = double.tryParse(val) ?? 0;
              return "${(lbs / 2.20462).toStringAsFixed(2)} kg";
            }),
          ],
        ),
      ),
    );
  }
}

// ---------------- Temperature ----------------
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
            _converterCard("Celsius to Fahrenheit", "Enter °C", (val) {
              double c = double.tryParse(val) ?? 0;
              return "${(c * 9 / 5 + 32).toStringAsFixed(2)} °F";
            }),
            const SizedBox(height: 16),
            _converterCard("Fahrenheit to Celsius", "Enter °F", (val) {
              double f = double.tryParse(val) ?? 0;
              return "${((f - 32) * 5 / 9).toStringAsFixed(2)} °C";
            }),
          ],
        ),
      ),
    );
  }
}

// ---------------- Date Calculator ----------------
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
            _dateDiffCard(),
            const SizedBox(height: 16),
            _ageCalculatorCard(),
          ],
        ),
      ),
    );
  }
}

// ---------------- BMI ----------------
class BMICalcPage extends StatelessWidget {
  const BMICalcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BMI Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [_bmiCard()],
        ),
      ),
    );
  }
}

// ---------------- Simple Interest ----------------
class InterestCalcPage extends StatelessWidget {
  const InterestCalcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Simple Interest Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [_simpleInterestCard()],
        ),
      ),
    );
  }
}

// ==========================================
// ================= Utility Widgets =========
// ==========================================

Widget _converterCard(String title, String hint, String Function(String) calculate) {
  final TextEditingController controller = TextEditingController();
  String result = "";

  return StatefulBuilder(
    builder: (context, setState) => Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: hint, border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  result = calculate(controller.text);
                });
              },
              child: const Text("Calculate"),
            ),
            const SizedBox(height: 8),
            Text("Result: $result", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
  );
}

Widget _dateDiffCard() {
  DateTime? date1;
  DateTime? date2;
  String result = "";

  return StatefulBuilder(
    builder: (context, setState) => Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Date Difference Calculator", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => date1 = picked);
              },
              child: Text(date1 == null ? "Select First Date" : date1.toString().split(" ")[0]),
            ),
            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => date2 = picked);
              },
              child: Text(date2 == null ? "Select Second Date" : date2.toString().split(" ")[0]),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (date1 != null && date2 != null) {
                  final diff = date2!.difference(date1!).inDays;
                  setState(() {
                    result = "$diff days";
                  });
                }
              },
              child: const Text("Calculate Difference"),
            ),
            const SizedBox(height: 8),
            Text("Result: $result", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
  );
}

Widget _ageCalculatorCard() {
  DateTime? birthDate;
  String result = "";

  return StatefulBuilder(
    builder: (context, setState) => Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Age Calculator", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null) setState(() => birthDate = picked);
              },
              child: Text(birthDate == null ? "Select Birthdate" : birthDate.toString().split(" ")[0]),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (birthDate != null) {
                  final today = DateTime.now();
                  final age = today.year - birthDate!.year - ((today.month < birthDate!.month || (today.month == birthDate!.month && today.day < birthDate!.day)) ? 1 : 0);
                  setState(() {
                    result = "$age years";
                  });
                }
              },
              child: const Text("Calculate Age"),
            ),
            const SizedBox(height: 8),
            Text("Age: $result", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
  );
}

Widget _bmiCard() {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String result = "";

  return StatefulBuilder(
    builder: (context, setState) => Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("BMI Calculator", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Height in meters", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Weight in kg", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final double height = double.tryParse(heightController.text) ?? 0;
                final double weight = double.tryParse(weightController.text) ?? 0;
                if (height > 0 && weight > 0) {
                  final bmi = weight / (height * height);
                  setState(() {
                    result = "BMI: ${bmi.toStringAsFixed(2)}";
                  });
                }
              },
              child: const Text("Calculate BMI"),
            ),
            const SizedBox(height: 8),
            Text(result, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
  );
}

Widget _simpleInterestCard() {
  final TextEditingController principalController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  String result = "";

  return StatefulBuilder(
    builder: (context, setState) => Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Simple Interest Calculator", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: principalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Principal", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Rate (%)", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: timeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Time (years)", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                double principal = double.tryParse(principalController.text) ?? 0;
                double rate = double.tryParse(rateController.text) ?? 0;
                double time = double.tryParse(timeController.text) ?? 0;
                if (principal > 0 && rate > 0 && time > 0) {
                  double interest = (principal * rate * time) / 100;
                  setState(() {
                    result = "Interest: ${interest.toStringAsFixed(2)}";
                  });
                }
              },
              child: const Text("Calculate Interest"),
            ),
            const SizedBox(height: 8),
            Text(result, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
  );
}
