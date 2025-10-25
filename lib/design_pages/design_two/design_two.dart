import 'package:flutter/material.dart';

class DesignTwo extends StatefulWidget {
  final String qrData;

  const DesignTwo({super.key, required this.qrData});

  @override
  State<DesignTwo> createState() => _DesignTwoState();
}

class _DesignTwoState extends State<DesignTwo> {
  // Track which accordions are expanded
  final Map<String, bool> _expandedSkills = {'Python': false, 'Dart': false, 'HTML': false, 'CSS': false, 'Firebase': false,};
  final Map<String, IconData> _skillIcons = {'Python': Icons.code, 'Dart': Icons.flutter_dash, 'HTML': Icons.language, 'CSS': Icons.style, 'Firebase': Icons.cloud,};
  // Text controllers for each skill to allow writing notes
  final Map<String, TextEditingController> _controllers = {'Python': TextEditingController(), 'Dart': TextEditingController(), 'HTML': TextEditingController(), 'CSS': TextEditingController(), 'Firebase': TextEditingController(),};

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text("Premium Learning Dashboard", style: TextStyle(color: Colors.white),), backgroundColor: Colors.deepPurple, centerTitle: true, elevation: 4,),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            // Main premium card
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(colors: [Colors.deepPurple, Colors.purpleAccent], begin: Alignment.topLeft, end: Alignment.bottomRight,),
                boxShadow: [BoxShadow(color: Colors.purple.shade200.withValues(alpha: 0.5), blurRadius: 15, offset: const Offset(5, 7))],
              ),
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.school, size: 50, color: Colors.deepPurple),
                  ),
                  const SizedBox(height: 20),
                  const Text("Prothes Barai", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5),
                  const Text("Premium Learner", style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w500),),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        const Text("Scanned QR Code", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                        const SizedBox(height: 10),
                        Text(widget.qrData, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Accordion-style skill cards inside same class
            Column(
              children: _expandedSkills.keys.map((skill) {
                bool isExpanded = _expandedSkills[skill]!;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isExpanded ? Colors.deepPurple.shade50 : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 8, offset: const Offset(3, 3))],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        setState(() {
                          _expandedSkills[skill] = !isExpanded;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(_skillIcons[skill], color: Colors.deepPurple, size: 28),
                                const SizedBox(width: 15),
                                Text(skill, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                const Spacer(),
                                Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.deepPurple,)
                              ],
                            ),
                            if (isExpanded)
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Column(
                                  children: [
                                    const Text("This is a premium course section. You can write notes, practice exercises, and track progress here.", style: TextStyle(fontSize: 14, color: Colors.black87),),
                                    const SizedBox(height: 10),
                                    TextField(controller: _controllers[skill],
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                        hintText: "Write your notes here...",
                                        filled: true,
                                        fillColor: Colors.deepPurple.shade50,
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none,),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
