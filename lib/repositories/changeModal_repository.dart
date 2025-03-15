import 'package:stock_flutter/services/changeModalService.dart';

class ChangeModalRepository {
  Future<void> saveModal(String modalName) async {
    await ChangeModalService.saveModalState(modalName);
  }

  Future<String?> getCurrentModal() async {
    return await ChangeModalService.getModalState();
  }
}
