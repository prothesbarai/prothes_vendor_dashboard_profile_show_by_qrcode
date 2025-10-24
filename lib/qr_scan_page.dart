import 'package:flutter/material.dart';
import 'package:prothesvendordashboardprofileshowbyqrcode/design_pages/design_one.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import 'design_pages/design_three.dart';
import 'design_pages/design_two.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({super.key});

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrViewController;


  void _onQRViewCreated(QRViewController controller) {
    qrViewController = controller;

    controller.scannedDataStream.listen((scanData) {
      if(!mounted) return;
      _onQRScanned(scanData.code!, context);
      controller.pauseCamera();
    });
  }


  void _onQRScanned(String qrData, BuildContext context) {
    Widget page;
    switch (qrData) {
      case "ANGKAN_UI":
        page = DesignOne(qrData: qrData);
        break;
      case "PROTHES_UI":
        page = DesignTwo(qrData: qrData);
        break;
      case "SHREYASI_UI":
        page = DesignThree(qrData: qrData);
        break;
      // add more QR codes and pages here
      default:
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Unknown QR code")),);
        return;
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page),);
  }



  @override
  void dispose() {
    qrViewController?.disposed;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR Code")),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(borderColor: Colors.white,borderRadius: 10,borderLength: 30,borderWidth: 5,cutOutSize: 250,),
      )
    );
  }

}
