// ResultQrCode

import 'package:flutter/material.dart';
import 'package:stock_flutter/constants/app_constants.dart';
import 'package:stock_flutter/utils/utils.dart';
import 'package:stock_flutter/widgets/header.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stock_flutter/widgets/text_cus.dart';
import 'package:image_save/image_save.dart';
import 'package:flutter/services.dart';

class ResultQrCode extends StatefulWidget {
  final String jsonData;
  ResultQrCode({super.key, required this.jsonData});

  @override
  State<ResultQrCode> createState() => _ResultQrCodeState();
}

class _ResultQrCodeState extends State<ResultQrCode> {
  @override
  void initState() {
    super.initState();
    print('du lieu nhan: ${widget.jsonData}');
  }

  final ScreenshotController _screenshotController = ScreenshotController();

  Future<void> saveQRCode() async {
    if (await Permission.storage.request().isDenied) {
      showPermissionDialog();
      return;
    }

    try {
      // Chụp màn hình QR Code
      final Uint8List? imageBytes = await _screenshotController.capture();
      if (imageBytes == null) {
        print(' Không thể chụp ảnh QR Code');
        return;
      }

      final bool success = await ImageSave.saveImage(imageBytes, "image.png",
              albumName: "QRCode") ??
          false;

      if (success) {
        showSuccessSnackbar(context, 'Lưu ảnh QR Code thành công!', 1);
      } else {
        showSuccessSnackbar(context, 'Lưu ảnh QR Code thất bại!', 2);
      }
    } catch (e) {
      print('Lỗi khi lưu ảnh: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
        ),
        padding:
            const EdgeInsets.only(right: 10, left: 10, top: 40, bottom: 25),
        child: Column(
          children: [
            HeaderCus(
              fnLeftPress: () {
                Utils.navigatorGoBack(context);
              },
              fnRightPress: () {},
              iconData: Icons.arrow_back_ios,
              title: 'Kết quả',
              showIconRight: false,
            ),
            const SizedBox(height: 20),
            Center(
              child: Screenshot(
                controller: _screenshotController,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.transparent,
                  child: QrImageView(
                    data: widget.jsonData,
                    version: QrVersions.auto,
                    size: 250.0,
                    gapless: false,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: saveQRCode,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.c_blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: textCus(
                  context: context,
                  text: 'Tải QR Code',
                  color: AppColors.c_white,
                  fontWeight: FontWeight.bold,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cấp quyền truy cập'),
        content: const Text(
          'Ứng dụng cần quyền truy cập ảnh để lưu QR Code. '
          'Vui lòng cấp quyền trong Cài đặt.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.pop(context);
            },
            child: const Text('Mở Cài đặt'),
          ),
        ],
      ),
    );
  }

  void showSuccessSnackbar(BuildContext context, String message, int type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: textCus(
          context: context,
          text: message,
          fontSize: AppSizeText.sizeText14,
          fontWeight: FontWeight.w600,
          color: AppColors.c_white,
        ),
        backgroundColor: type == 1 ? Colors.green : Colors.red[400],
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
