import 'package:flutter/material.dart';

class DesignOne extends StatelessWidget {
  final String qrData;

  const DesignOne({super.key, required this.qrData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Design One",style: TextStyle(color: Colors.white),), backgroundColor: Colors.deepPurple, elevation: 4, centerTitle: true,),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.deepPurple, Colors.purpleAccent], begin: Alignment.topLeft, end: Alignment.bottomRight,),),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Greeting Card
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                elevation: 8,
                shadowColor: Colors.black54,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(Icons.verified_user, size: 80, color: Colors.deepPurple),
                      const SizedBox(height: 20),
                      Text("Welcome to Design One", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,color: Colors.deepPurple.shade700,), textAlign: TextAlign.center,),
                      const SizedBox(height: 15),
                      Text("Prothes Barai", style: TextStyle(fontSize: 18, color: Colors.grey.shade800,), textAlign: TextAlign.center,),
                      const SizedBox(height: 20),
                      // Show scanned QR code
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(color: Colors.deepPurple.shade50, borderRadius: BorderRadius.circular(15),),
                        child: Column(
                          children: [
                            const Text("Scanned QR Code", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),),
                            const SizedBox(height: 10),
                            Text(qrData, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade800,),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Example design cards
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(4, (index) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.purpleAccent.shade100, Colors.deepPurple.shade300], begin: Alignment.topLeft, end: Alignment.bottomRight,),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 4),)],
                    ),
                    child: Center(child: Text("Premium Card ${index + 1}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18,), textAlign: TextAlign.center,)),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
