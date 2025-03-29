import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/srceens/qRScannerCamera/qRScannerCamera.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  String qrResult = "";

  void openCamera() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QRScannerCamera()),
    );

    if (result != null && mounted) {
      setState(() {
        qrResult = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          qrResult.isNotEmpty
              ? Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Kết quả: $qrResult',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: const Image(
                    image: AssetImage('assets/imgs/scan.png'),
                    height: 100,
                    width: 100,
                  ),
                ),
          GestureDetector(
            onTap: openCamera,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                color: AppColors.c_blue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: textCus(
                context: context,
                text: 'Quét',
                color: AppColors.c_white,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
