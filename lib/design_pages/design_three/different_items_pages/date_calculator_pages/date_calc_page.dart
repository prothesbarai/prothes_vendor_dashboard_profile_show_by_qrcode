import 'package:flutter/material.dart';

class DateCalcPage extends StatefulWidget {
  const DateCalcPage({super.key});

  @override
  State<DateCalcPage> createState() => _DateCalcPageState();
}

class _DateCalcPageState extends State<DateCalcPage> {
  DateTime? date1;
  DateTime? date2;
  Map<String, String> results = {};


  /// >>> Calculation Difference ===============================================
  void _calculateDifference() {
    if (date1 == null || date2 == null) return;

    final difference = date2!.difference(date1!);
    final isNegative = difference.isNegative;
    final absDifference = difference.abs();

    // Calculate different time units
    final days = absDifference.inDays;
    final weeks = (days / 7).toStringAsFixed(2);
    final months = (days / 30.44).toStringAsFixed(2); // Average month length
    final years = (days / 365.25).toStringAsFixed(2); // Average year length
    final hours = absDifference.inHours;
    final minutes = absDifference.inMinutes;
    final seconds = absDifference.inSeconds;

    // Determine which date is earlier/later for summary
    final earlierDate = isNegative ? date2! : date1!;
    final laterDate = isNegative ? date1! : date2!;
    final direction = isNegative ? "before" : "after";

    setState(() {
      results = {
        'days': '$days',
        'weeks': weeks,
        'months': months,
        'years': years,
        'hours': '$hours',
        'minutes': '$minutes',
        'seconds': '$seconds',
        'summary': '${_formatDate(laterDate)} is $days days $direction ${_formatDate(earlierDate)}',
      };
    });
  }


  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Date Calculator"), centerTitle: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(Icons.calendar_today, size: 48, color: Colors.blue[700],),
                      const SizedBox(height: 8),
                      const Text("Date Difference Calculator", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87,), textAlign: TextAlign.center,),
                      const SizedBox(height: 4),
                      const Text("Select two dates to calculate the difference", style: TextStyle(fontSize: 14, color: Colors.grey,), textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),
        
              const SizedBox(height: 24),
        
              // Date Selection Cards
              Row(
                children: [
                  Expanded(
                    child: _buildDateCard("First Date", date1, () async {
                        final picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100));
                        if (picked != null) {
                          setState(() => date1 = picked);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDateCard("Second Date", date2, () async {
                        final picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100),);
                        if (picked != null) {
                          setState(() => date2 = picked);
                        }
                      },
                    ),
                  ),
                ],
              ),
        
              const SizedBox(height: 24),
        
              // Calculate Button
              ElevatedButton(
                onPressed: _calculateDifference,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[700], padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),),
                child: const Text("Calculate Difference", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white,),),
              ),
              const SizedBox(height: 24),
              // Results Card
              if (results.isNotEmpty)...[
                _buildResultsCard(),
                SizedBox(height: 100,),
              ]
            ],
          ),
        ),
      ),
    );
  }


  /// >>> Design Two Selection Date Card =======================================
  Widget _buildDateCard(String title, DateTime? date, VoidCallback onTap) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey,),),
              const SizedBox(height: 8),
              Text(date == null ? "Select Date" : _formatDate(date), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: date == null ? Colors.grey : Colors.blue[700],), textAlign: TextAlign.center,),
              const SizedBox(height: 4),
              Icon(Icons.calendar_month, color: date == null ? Colors.grey : Colors.blue[700], size: 20,),
            ],
          ),
        ),
      ),
    );
  }


  /// >>> Result Section Card Design ===========================================
  Widget _buildResultsCard() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.analytics, color: Colors.green, size: 20),
                SizedBox(width: 8),
                Text("Calculation Results", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87,),),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),

            // Time Units in a grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.9,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildResultItem("Days", results['days']!, Icons.calendar_view_day),
                _buildResultItem("Weeks", results['weeks']!, Icons.calendar_view_week),
                _buildResultItem("Months", results['months']!, Icons.calendar_view_month),
                _buildResultItem("Years", results['years']!, Icons.calendar_today),
                _buildResultItem("Hours", results['hours']!, Icons.access_time),
                _buildResultItem("Minutes", results['minutes']!, Icons.timer),
                _buildResultItem("Seconds", results['seconds']!, Icons.schedule),
              ],
            ),

            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),

            // Total difference summary
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8),),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.blue[700], size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(results['summary']!, style: TextStyle(fontSize: 14, color: Colors.blue[800], fontWeight: FontWeight.w500,),),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  /// >>> Result Section Item Design ===========================================
  Widget _buildResultItem(String title, String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey[200]!),),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Icon(icon, size: 18, color: Colors.blue[700]),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey,fontWeight: FontWeight.bold,),),
                Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87,),),
              ],
            ),
          ),
        ],
      ),
    );
  }

}