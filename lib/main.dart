import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prothesvendordashboardprofileshowbyqrcode/design_pages/design_three/design_three.dart';
import 'package:prothesvendordashboardprofileshowbyqrcode/qr_scan_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]),
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, systemNavigationBarColor: Colors.transparent, systemNavigationBarDividerColor: Colors.transparent, statusBarIconBrightness: Brightness.light, systemNavigationBarIconBrightness: Brightness.light,),);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),),
      home: const DesignThree(qrData: "qrData")
    );
  }
}

