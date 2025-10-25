import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgeCalculatorPage extends StatefulWidget {
  const AgeCalculatorPage({super.key});

  @override
  State<AgeCalculatorPage> createState() => _AgeCalculatorPageState();
}

class _AgeCalculatorPageState extends State<AgeCalculatorPage> {
  DateTime? dob;
  DateTime today = DateTime.now();
  int years = 0, months = 0, days = 0;
  int totalMonths = 0, totalWeeks = 0, totalDays = 0;
  int totalHours = 0, totalMinutes = 0;
  DateTime? nextBirthday;
  String nextBirthdayDayName = "";
  int nextBirthdayMonths = 0, nextBirthdayDays = 0;
  // For custom date picker
  final List<String> monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  int selectedDay = DateTime.now().day;

  @override
  void initState() {
    super.initState();
    // Set default Date of Birth to 15 Jul 1999
    dob = DateTime(1999, 7, 15);
    // Set default today date to current date
    today = DateTime.now();
    // Calculate age with default values
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculateAge();
    });
  }

  void calculateAge() {
    if (dob == null) return;
    DateTime currentDate = today;
    // Calculate age in years, months, days
    int y = currentDate.year - dob!.year;
    int m = currentDate.month - dob!.month;
    int d = currentDate.day - dob!.day;

    if (d < 0) {
      m -= 1;
      d += DateTime(currentDate.year, currentDate.month, 0).day;
    }
    if (m < 0) {
      y -= 1;
      m += 12;
    }

    // Calculate totals
    totalDays = currentDate.difference(dob!).inDays;
    totalWeeks = totalDays ~/ 7;
    totalMonths = (y * 12) + m;
    totalHours = totalDays * 24;
    totalMinutes = totalHours * 60;

    // Next birthday calculation
    DateTime nb = DateTime(currentDate.year, dob!.month, dob!.day);
    if (nb.isBefore(currentDate) || nb.isAtSameMomentAs(currentDate)) {nb = DateTime(currentDate.year + 1, dob!.month, dob!.day);}

    // Calculate time until next birthday
    DateTime nextBd = nb;
    int bdMonths = nextBd.year - currentDate.year;
    int bdM = bdMonths * 12 + nextBd.month - currentDate.month;
    int bdD = nextBd.day - currentDate.day;

    if (bdD < 0) {
      bdM -= 1;
      bdD += DateTime(nextBd.year, nextBd.month, 0).day;
    }

    setState(() {
      years = y;
      months = m;
      days = d;
      nextBirthday = nb;
      nextBirthdayDayName = DateFormat('EEEE').format(nb);
      nextBirthdayMonths = bdM;
      nextBirthdayDays = bdD;
    });
  }

  void _showCustomDatePicker(bool isDob) {
    if (isDob) {
      selectedYear = dob!.year;
      selectedMonth = dob!.month;
      selectedDay = dob!.day;
    } else {
      selectedYear = today.year;
      selectedMonth = today.month;
      selectedDay = today.day;
    }

    // Controllers for auto scroll to current selected
    final dayController = FixedExtentScrollController(initialItem: selectedDay - 1);
    final monthController = FixedExtentScrollController(initialItem: selectedMonth - 1);
    final yearController = FixedExtentScrollController(initialItem: selectedYear - 1900);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),),),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.grey[50], borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),),),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel', style: TextStyle(color: Colors.deepOrange, fontSize: 16),),
                      ),
                      Text(isDob ? 'Select Date of Birth' : 'Select Today Date', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            if (isDob) {
                              dob = DateTime(selectedYear, selectedMonth, selectedDay);
                            } else {
                              today = DateTime(selectedYear, selectedMonth, selectedDay);
                            }
                          });
                          Navigator.pop(context);
                          calculateAge();
                        },
                        child: const Text('OK', style: TextStyle(color: Colors.deepOrange, fontSize: 16, fontWeight: FontWeight.bold,),),
                      ),
                    ],
                  ),
                ),

                // Custom Picker
                Expanded(
                  child: Row(
                    children: [
                      // Days
                      Expanded(
                        child: ListWheelScrollView.useDelegate(
                          controller: dayController,
                          itemExtent: 50,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setModalState(() {
                              selectedDay = index + 1;
                              final lastDay = DateTime(selectedYear, selectedMonth + 1, 0).day;
                              if (selectedDay > lastDay) selectedDay = lastDay;
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              if (index < 0 || index >= 31) return null;
                              final day = index + 1;
                              final isSelected = day == selectedDay;
                              return Center(child: Text(day.toString(), style: TextStyle(fontSize: isSelected ? 22 : 18, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? Colors.deepOrange : Colors.black,),),);
                            },
                          ),
                        ),
                      ),

                      // Months
                      Expanded(
                        child: ListWheelScrollView.useDelegate(
                          controller: monthController,
                          itemExtent: 50,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setModalState(() {
                              selectedMonth = index + 1;
                              final lastDay = DateTime(selectedYear, selectedMonth + 1, 0).day;
                              if (selectedDay > lastDay) selectedDay = lastDay;
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              if (index < 0 || index >= 12) return null;
                              final month = index + 1;
                              final isSelected = month == selectedMonth;
                              return Center(child: Text(monthNames[index], style: TextStyle(fontSize: isSelected ? 22 : 18, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? Colors.deepOrange : Colors.black,),),);
                            },
                          ),
                        ),
                      ),

                      // Years
                      Expanded(
                        child: ListWheelScrollView.useDelegate(
                          controller: yearController,
                          itemExtent: 50,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setModalState(() {
                              selectedYear = 1900 + index;
                              final lastDay = DateTime(selectedYear, selectedMonth + 1, 0).day;
                              if (selectedDay > lastDay) selectedDay = lastDay;
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              if (index < 0 || index > 200) return null;
                              final year = 1900 + index;
                              final isSelected = year == selectedYear;
                              return Center(child: Text(year.toString(), style: TextStyle(fontSize: isSelected ? 22 : 18, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? Colors.deepOrange : Colors.black,),),);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Age Calculator"),centerTitle: true,),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text("Age", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),),
            const SizedBox(height: 20),

            // Date of Birth - Clickable field
            _buildClickableDateRow("Date of birth", dob, () => _showCustomDatePicker(true)),
            const SizedBox(height: 10),

            // Today - Clickable field
            _buildClickableDateRow("Today", today, () => _showCustomDatePicker(false)),
            const SizedBox(height: 20),

            const Divider(thickness: 1),
            const SizedBox(height: 20),

            // Age and Next Birthday Card
            if (dob != null) _buildAgeCard(),

            const SizedBox(height: 20),

            // Summary Section
            if (dob != null) _buildSummaryCard(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }


  /// >>> Build Clickable Date Row =============================================
  Widget _buildClickableDateRow(String title, DateTime? date, VoidCallback onTap) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600,),),),
        Expanded(
          flex: 3,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8),),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(date == null ? "Select date" : DateFormat("MMM dd, yyyy").format(date), style: TextStyle(fontSize: 16, color: date == null ? Colors.grey.shade600 : Colors.black,),),
                  Icon(Icons.calendar_today, color: Colors.deepOrange, size: 20,),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// >>> Build Age Design card ================================================
  Widget _buildAgeCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Age", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),),
                    Row(children: [
                      Text("$years", style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.deepOrange,),),
                      const SizedBox(width: 10,),
                      Text("years", style: const TextStyle(fontSize: 16, color: Colors.grey,),),
                    ],),
                    SizedBox(width:100,child: Divider(color: Colors.grey[300], thickness: 1,)),
                    Text("$months months | $days days", style: const TextStyle(fontSize: 15, color: Colors.grey,),),
                  ],
                ),

                SizedBox(height: 150, child: VerticalDivider(color: Colors.grey[300], thickness: 1, width: 1,),),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Next birthday", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Icon(Icons.cake,color: Colors.deepOrange,size: 30,),
                    ),
                    Text(nextBirthdayDayName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange,),),
                    SizedBox(width:120,child: Divider(color: Colors.grey[300], thickness: 1,)),
                    Text("$nextBirthdayMonths months | $nextBirthdayDays days", style: const TextStyle(fontSize: 15, color: Colors.grey,),),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// >>> Design & Build Summary Card ==========================================
  Widget _buildSummaryCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
            const SizedBox(height: 16),
            // First row: Years, Months, Weeks
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem("Years", years.toString()),
                _buildSummaryItem("Months", totalMonths.toString()),
                _buildSummaryItem("Weeks", totalWeeks.toString()),
              ],
            ),
            const SizedBox(height: 16),
            // Second row: Days, Hours, Minutes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem("Days", totalDays.toString()),
                _buildSummaryItem("Hours", totalHours.toString()),
                _buildSummaryItem("Minutes", totalMinutes.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// >>> Build Summery Item ===================================================
  Widget _buildSummaryItem(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey,),),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepOrange,),),
      ],
    );
  }


}