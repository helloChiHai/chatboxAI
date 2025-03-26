import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/widgets/text_cus.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  String qrText = "";

  Future<void> _requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();

    if (status.isDenied) {
      _showPermissionDialog();
    } else if (status.isPermanentlyDenied) {
      _openAppSettings();
    } else if (status.isGranted) {
      _scanQRCode();
    }
  }

  Future<void> _scanQRCode() async {
    try {
      String scannedCode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", // Màu của nút cancel
        "Hủy", // Văn bản nút hủy
        true, // Bật đèn flash nếu cần
        ScanMode.QR, // Chỉ quét QR code
      );

      if (!mounted) return;

      setState(() {
        qrText = scannedCode == "-1" ? "Quét bị hủy" : scannedCode;
      });
    } catch (e) {
      setState(() {
        qrText = "Lỗi khi quét: $e";
      });
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Quyền bị từ chối"),
        content: const Text("Bạn cần cấp quyền camera để quét QR."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Đóng"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _openAppSettings();
            },
            child: const Text("Mở cài đặt"),
          ),
        ],
      ),
    );
  }

  void _openAppSettings() {
    openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: const Image(
              image: AssetImage('assets/imgs/scan.png'),
              height: 130,
              width: 130,
            ),
          ),
          GestureDetector(
            onTap: _requestCameraPermission,
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
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 20),
          qrText.isNotEmpty
              ? Text(
                  'Kết quả: 100 điểm',
                  // 'Kết quả: $qrText',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
