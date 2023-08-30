import 'package:get/get.dart';
import 'package:gohomy/model/motel_room.dart';
import 'package:gohomy/screen/data_app_controller.dart';
import 'package:gohomy/screen/users_bill/user_bill_controller.dart';

import '../../../../components/arlert/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/bill.dart';
import '../../../../model/image_assset.dart';

class UserPaymentController extends GetxController {
  UserBillController userBillController = UserBillController();
  var listImages = RxList<ImageData>([]);
  var bill = Bill().obs;
  var motel = MotelRoom().obs;
  DataAppController dataAppController = Get.find();
  Future<void> putUserPayment(billId) async {
    try {
      var data = await RepositoryManager.userManageRepository
          .putUserPayment(bill: bill.value, billId: billId);
      SahaAlert.showSuccess(message: "Thành công");

      Get.back();
      Get.back();
      Get.back(result: 'pay_success');
      dataAppController.getBadge();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
